using System;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security;
using System.Text;
using System.Threading;

using ICSharpCode.SharpZipLib.Zip.Compression;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;
using ICSharpCode.SharpZipLib.GZip;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Core;

using NUnit.Framework;
using ICSharpCode.SharpZipLib.Tests.TestSupport;

namespace ICSharpCode.SharpZipLib.Tests.Zip
{
	#region Local Support Classes
	class RuntimeInfo
	{
		public RuntimeInfo(CompressionMethod method, int compressionLevel, int size, string password, bool getCrc)
		{
			this.method = method;
			this.compressionLevel = compressionLevel;
			this.password = password;
			this.size = size;
			this.random = false;

			original = new byte[Size];
			if (random)
			{
				System.Random rnd = new Random();
				rnd.NextBytes(original);
			}
			else
			{
				for (int i = 0; i < size; ++i)
				{
					original[i] = (byte)'A';
				}
			}

			if (getCrc)
			{
				Crc32 crc32 = new Crc32();
				crc32.Update(original, 0, size);
				crc = crc32.Value;
			}
		}


		public RuntimeInfo(string password, bool isDirectory)
		{
			this.method = CompressionMethod.Stored;
			this.compressionLevel = 1;
			this.password = password;
			this.size = 0;
			this.random = false;
			isDirectory_ = isDirectory;
			original = new byte[0];
		}


		public byte[] Original
		{
			get { return original; }
		}

		public CompressionMethod Method
		{
			get { return method; }
		}

		public int CompressionLevel
		{
			get { return compressionLevel; }
		}

		public int Size
		{
			get { return size; }
		}

		public string Password
		{
			get { return password; }
		}

		bool Random
		{
			get { return random; }
		}

		public long Crc
		{
			get { return crc; }
		}

		public bool IsDirectory
		{
			get { return isDirectory_; }
		}

		#region Instance Fields
		byte[] original;
		CompressionMethod method;
		int compressionLevel;
		int size;
		string password;
		bool random;
		bool isDirectory_;
		long crc = -1;
		#endregion
	}

	class MemoryDataSource : IStaticDataSource
	{
		#region Constructors
		/// <summary>
		/// Initialise a new instance.
		/// </summary>
		/// <param name="data">The data to provide.</param>
		public MemoryDataSource(byte[] data)
		{
			data_ = data;
		}
		#endregion

		#region IDataSource Members

		/// <summary>
		/// Get a Stream for this <see cref="DataSource"/>
		/// </summary>
		/// <returns>Returns a <see cref="Stream"/></returns>
		public Stream GetSource()
		{
			return new MemoryStream(data_);
		}
		#endregion

		#region Instance Fields
		byte[] data_;
		#endregion
	}

	class StringMemoryDataSource : MemoryDataSource
	{
		public StringMemoryDataSource(string data)
			: base(Encoding.ASCII.GetBytes(data))
		{
		}
	}
	#endregion

	#region ZipBase
	public class ZipBase
	{
		static protected string GetTempFilePath()
		{
			string result = null;
			try
			{
				result = Path.GetTempPath();
			}
			catch (SecurityException)
			{
			}
			return result;
		}

		protected byte[] MakeInMemoryZip(bool withSeek, params object[] createSpecs)
		{
			MemoryStream ms;

			if (withSeek == true) {
				ms = new MemoryStream();
			}
			else {
				ms = new MemoryStreamWithoutSeek();
			}

			using (ZipOutputStream outStream = new ZipOutputStream(ms)) {
				for (int counter = 0; counter < createSpecs.Length; ++counter) {
					RuntimeInfo info = createSpecs[counter] as RuntimeInfo;
					outStream.Password = info.Password;

					if (info.Method != CompressionMethod.Stored) {
						outStream.SetLevel(info.CompressionLevel); // 0 - store only to 9 - means best compression
					}

					string entryName;

					if (info.IsDirectory) {
						entryName = "dir" + counter + "/";
					}
					else {
						entryName = "entry" + counter + ".tst";
					}

					ZipEntry entry = new ZipEntry(entryName);
					entry.CompressionMethod = info.Method;
					if (info.Crc >= 0) {
						entry.Crc = info.Crc;
					}

					outStream.PutNextEntry(entry);

					if (info.Size > 0) {
						outStream.Write(info.Original, 0, info.Original.Length);
					}
				}
			}
			return ms.ToArray();
		}

		protected byte[] MakeInMemoryZip(ref byte[] original, CompressionMethod method,
			int compressionLevel, int size, string password, bool withSeek)
		{
			MemoryStream ms;

			if (withSeek == true) {
				ms = new MemoryStream();
			}
			else {
				ms = new MemoryStreamWithoutSeek();
			}

			using (ZipOutputStream outStream = new ZipOutputStream(ms))
			{
				outStream.Password = password;

				if (method != CompressionMethod.Stored)
				{
					outStream.SetLevel(compressionLevel); // 0 - store only to 9 - means best compression
				}

				ZipEntry entry = new ZipEntry("dummyfile.tst");
				entry.CompressionMethod = method;

				outStream.PutNextEntry(entry);

				if (size > 0)
				{
					System.Random rnd = new Random();
					original = new byte[size];
					rnd.NextBytes(original);

					outStream.Write(original, 0, original.Length);
				}
			}
			return ms.ToArray();
		}

		protected static void MakeTempFile(string name, int size)
		{
			using (FileStream fs = File.Create(name))
			{
				byte[] buffer = new byte[4096];
				while (size > 0)
				{
					fs.Write(buffer, 0, Math.Min(size, buffer.Length));
					size -= buffer.Length;
				}
			}
		}

		static protected byte ScatterValue(byte rhs)
		{
			return (byte)((rhs * 253 + 7) & 0xff);
		}


		static void AddKnownDataToEntry(ZipOutputStream zipStream, int size)
		{
			if (size > 0)
			{
				byte nextValue = 0;
				int bufferSize = Math.Min(size, 65536);
				byte[] data = new byte[bufferSize];
				int currentIndex = 0;
				for (int i = 0; i < size; ++i)
				{

					data[currentIndex] = nextValue;
					nextValue = ScatterValue(nextValue);

					currentIndex += 1;
					if ((currentIndex >= data.Length) || (i + 1 == size))
					{
						zipStream.Write(data, 0, currentIndex);
						currentIndex = 0;
					}
				}
			}
		}

		public void WriteToFile(string fileName, byte[] data)
		{
			using (FileStream fs = File.Open(fileName, FileMode.Create, FileAccess.ReadWrite, FileShare.Read))
			{
				fs.Write(data, 0, data.Length);
			}
		}

		#region MakeZipFile Names
		protected void MakeZipFile(Stream storage, bool isOwner, string[] names, int size, string comment)
		{
			using (ZipOutputStream zOut = new ZipOutputStream(storage))
			{
				zOut.IsStreamOwner = isOwner;
				zOut.SetComment(comment);
				for (int i = 0; i < names.Length; ++i)
				{
					zOut.PutNextEntry(new ZipEntry(names[i]));
					AddKnownDataToEntry(zOut, size);
				}
				zOut.Close();
			}
		}

		protected void MakeZipFile(string name, string[] names, int size, string comment)
		{
			using (FileStream fs = File.Create(name))
			{
				using (ZipOutputStream zOut = new ZipOutputStream(fs))
				{
					zOut.SetComment(comment);
					for (int i = 0; i < names.Length; ++i)
					{
						zOut.PutNextEntry(new ZipEntry(names[i]));
						AddKnownDataToEntry(zOut, size);
					}
					zOut.Close();
				}
				fs.Close();
			}
		}
		#endregion
		
		#region MakeZipFile Entries
		protected void MakeZipFile(string name, string entryNamePrefix, int entries, int size, string comment)
		{
			using (FileStream fs = File.Create(name))
			using (ZipOutputStream zOut = new ZipOutputStream(fs))
			{
				zOut.SetComment(comment);
				for (int i = 0; i < entries; ++i)
				{
					zOut.PutNextEntry(new ZipEntry(entryNamePrefix + (i + 1).ToString()));
					AddKnownDataToEntry(zOut, size);
				}
			}
		}

		protected void MakeZipFile(Stream storage, bool isOwner,
			string entryNamePrefix, int entries, int size, string comment)
		{
			using (ZipOutputStream zOut = new ZipOutputStream(storage))
			{
				zOut.IsStreamOwner = isOwner;
				zOut.SetComment(comment);
				for (int i = 0; i < entries; ++i)
				{
					zOut.PutNextEntry(new ZipEntry(entryNamePrefix + (i + 1).ToString()));
					AddKnownDataToEntry(zOut, size);
				}
			}
		}


		#endregion

		protected static void CheckKnownEntry(Stream inStream, int expectedCount)
		{
			byte[] buffer = new byte[1024];

			int bytesRead;
			int total = 0;
			byte nextValue = 0;
			while ((bytesRead = inStream.Read(buffer, 0, buffer.Length)) > 0)
			{
				total += bytesRead;
				for (int i = 0; i < bytesRead; ++i)
				{
					Assert.AreEqual(nextValue, buffer[i], "Wrong value read from entry");
					nextValue = ScatterValue(nextValue);
				}
			}
			Assert.AreEqual(expectedCount, total, "Wrong number of bytes read from entry");
		}

		protected byte ReadByteChecked(Stream stream)
		{
			int rawValue = stream.ReadByte();
			Assert.IsTrue(rawValue >= 0);
			return (byte)rawValue;
		}

		protected int ReadInt(Stream stream)
		{
			return ReadByteChecked(stream) |
				(ReadByteChecked(stream) << 8) |
				(ReadByteChecked(stream) << 16) |
				(ReadByteChecked(stream) << 24);
		}

		protected long ReadLong(Stream stream)
		{
			long result = ReadInt(stream) & 0xffffffff;
			return result | (((long)ReadInt(stream)) << 32);
		}

	}

	#endregion

	class TestHelper
	{
		static public void SaveMemoryStream(MemoryStream ms, string fileName)
		{
			byte[] data = ms.ToArray();
			using (FileStream fs = File.Open(fileName, FileMode.Create, FileAccess.ReadWrite, FileShare.Read))
			{
				fs.Write(data, 0, data.Length);
			}
		}

		static public int CompareDosDateTimes(DateTime l, DateTime r)
		{
			// Compare dates to dos accuracy...
			// Ticks can be different yet all these values are still the same!
			int result = l.Year - r.Year;
			if (result == 0)
			{
				result = l.Month - r.Month;
				if (result == 0)
				{
					result = l.Day - r.Day;
					if (result == 0)
					{
						result = l.Hour - r.Hour;
						if (result == 0)
						{
							result = l.Minute - r.Minute;
							if (result == 0)
							{
								result = (l.Second / 2) - (r.Second / 2);
							}
						}
					}
				}
			}

			return result;
		}

	}

	[TestFixture]
	public class ZipEntryHandling : ZipBase
	{
		void PiecewiseCompare(ZipEntry lhs, ZipEntry rhs)
		{
			Type entryType = typeof(ZipEntry);
			BindingFlags binding = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;

			FieldInfo[] fields = entryType.GetFields(binding);

			Assert.Greater(fields.Length, 8, "Failed to find fields");

			foreach (FieldInfo info in fields)
			{
				object lValue = info.GetValue(lhs);
				object rValue = info.GetValue(rhs);

				Assert.AreEqual(lValue, rValue);
			}
		}

		/// <summary>
		/// Test that obsolete copy constructor works correctly.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void Copying()
		{
			long testCrc = 3456;
			long testSize = 99874276;
			long testCompressedSize = 72347;
			byte[] testExtraData = new byte[] { 0x00, 0x01, 0x00, 0x02, 0x0EF, 0xFE };
			string testName = "Namu";
			int testFlags = 4567;
			long testDosTime = 23434536;
			CompressionMethod testMethod = CompressionMethod.Deflated;

			string testComment = "A comment";

			ZipEntry source = new ZipEntry(testName);
			source.Crc = testCrc;
			source.Comment = testComment;
			source.Size = testSize;
			source.CompressedSize = testCompressedSize;
			source.ExtraData = testExtraData;
			source.Flags = testFlags;
			source.DosTime = testDosTime;
			source.CompressionMethod = testMethod;

#pragma warning disable 0618
			ZipEntry clone = new ZipEntry(source);
#pragma warning restore

			PiecewiseCompare(source, clone);
		}

		/// <summary>
		/// Check that cloned entries are correct.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void Cloning()
		{
			long testCrc = 3456;
			long testSize = 99874276;
			long testCompressedSize = 72347;
			byte[] testExtraData = new byte[] { 0x00, 0x01, 0x00, 0x02, 0x0EF, 0xFE };
			string testName = "Namu";
			int testFlags = 4567;
			long testDosTime = 23434536;
			CompressionMethod testMethod = CompressionMethod.Deflated;

			string testComment = "A comment";

			ZipEntry source = new ZipEntry(testName);
			source.Crc = testCrc;
			source.Comment = testComment;
			source.Size = testSize;
			source.CompressedSize = testCompressedSize;
			source.ExtraData = testExtraData;
			source.Flags = testFlags;
			source.DosTime = testDosTime;
			source.CompressionMethod = testMethod;

			ZipEntry clone = (ZipEntry)source.Clone();

			// Check values against originals
			Assert.AreEqual(testName, clone.Name, "Cloned name mismatch");
			Assert.AreEqual(testCrc, clone.Crc, "Cloned crc mismatch");
			Assert.AreEqual(testComment, clone.Comment, "Cloned comment mismatch");
			Assert.AreEqual(testExtraData, clone.ExtraData, "Cloned Extra data mismatch");
			Assert.AreEqual(testSize, clone.Size, "Cloned size mismatch");
			Assert.AreEqual(testCompressedSize, clone.CompressedSize, "Cloned compressed size mismatch");
			Assert.AreEqual(testFlags, clone.Flags, "Cloned flags mismatch");
			Assert.AreEqual(testDosTime, clone.DosTime, "Cloned DOSTime mismatch");
			Assert.AreEqual(testMethod, clone.CompressionMethod, "Cloned Compression method mismatch");

			// Check against source
			PiecewiseCompare(source, clone);
		}

		/// <summary>
		/// Setting entry comments to null should be allowed
		/// </summary>
		[Test]
		[Category("Zip")]
		public void NullEntryComment()
		{
			ZipEntry test = new ZipEntry("null");
			test.Comment = null;
		}

		/// <summary>
		/// Entries with null names arent allowed
		/// </summary>
		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(ArgumentNullException))]
		public void NullNameInConstructor()
		{
			string name = null;
			ZipEntry test = new ZipEntry(name);
		}		
		
		[Test]
		[Category("Zip")]
		public void DateAndTime()
		{
			ZipEntry ze = new ZipEntry("Pok");

			// -1 is not strictly a valid MS-DOS DateTime value.
			// ZipEntry is lenient about handling invalid values.
			ze.DosTime = -1;

			Assert.AreEqual(new DateTime(2107, 12, 31, 23, 59, 59), ze.DateTime);

			// 0 is a special value meaning Now.
			ze.DosTime = 0;
			TimeSpan diff = DateTime.Now - ze.DateTime;

			// Value == 2 seconds!
			ze.DosTime = 1;
			Assert.AreEqual(new DateTime(1980, 1, 1, 0, 0, 2), ze.DateTime);

			// Over the limit are set to max.
			ze.DateTime = new DateTime(2108, 1, 1);
			Assert.AreEqual(new DateTime(2107, 12, 31, 23, 59, 58), ze.DateTime);

			// Under the limit are set to min.
			ze.DateTime = new DateTime(1906, 12, 4);
			Assert.AreEqual(new DateTime(1980, 1, 1, 0, 0, 0), ze.DateTime);
		}

		[Test]
		[Category("Zip")]
		public void DateTimeSetsDosTime()
		{
			ZipEntry ze = new ZipEntry("Pok");

			long original = ze.DosTime;

			ze.DateTime = new DateTime(1987, 9, 12);
			Assert.AreNotEqual(original, ze.DosTime);
			Assert.AreEqual(0, TestHelper.CompareDosDateTimes(new DateTime(1987, 9, 12), ze.DateTime));
		}

	}

	/// <summary>
	/// This contains newer tests for stream handling. Much of this is still in GeneralHandling
	/// </summary>
	[TestFixture]
	public class StreamHandling : ZipBase
	{
		void MustFailRead(Stream s, byte[] buffer, int offset, int count)
		{
			bool exception = false;
			try
			{
				s.Read(buffer, offset, count);
			}
			catch
			{
				exception = true;
			}
			Assert.IsTrue(exception, "Read should fail");
		}

		[Test]
		[Category("Zip")]
		public void ParameterHandling()
		{
			byte[] buffer = new byte[10];
			byte[] emptyBuffer = new byte[0];

			MemoryStream ms = new MemoryStream();
			ZipOutputStream outStream = new ZipOutputStream(ms);
			outStream.IsStreamOwner = false;
			outStream.PutNextEntry(new ZipEntry("Floyd"));
			outStream.Write(buffer, 0, 10);
			outStream.Finish();

			ms.Seek(0, SeekOrigin.Begin);

			ZipInputStream inStream = new ZipInputStream(ms);
			ZipEntry e = inStream.GetNextEntry();

			MustFailRead(inStream, null, 0, 0);
			MustFailRead(inStream, buffer, -1, 1);
			MustFailRead(inStream, buffer, 0, 11);
			MustFailRead(inStream, buffer, 7, 5);
			MustFailRead(inStream, buffer, 0, -1);

			MustFailRead(inStream, emptyBuffer, 0, 1);

			int bytesRead = inStream.Read(buffer, 10, 0);
			Assert.AreEqual(0, bytesRead, "Should be able to read zero bytes");

			bytesRead = inStream.Read(emptyBuffer, 0, 0);
			Assert.AreEqual(0, bytesRead, "Should be able to read zero bytes");
		}

		/// <summary>
		/// Check that Zip64 descriptor is added to an entry OK.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void Zip64Descriptor()
		{
			MemoryStream msw = new MemoryStreamWithoutSeek();
			ZipOutputStream outStream = new ZipOutputStream(msw);
			outStream.UseZip64 = UseZip64.Off;

			outStream.IsStreamOwner = false;
			outStream.PutNextEntry(new ZipEntry("StripedMarlin"));
			outStream.WriteByte(89);
			outStream.Close();

			MemoryStream ms = new MemoryStream(msw.ToArray());
			using (ZipFile zf = new ZipFile(ms))
			{
				Assert.IsTrue(zf.TestArchive(true));
			}


			msw = new MemoryStreamWithoutSeek();
			outStream = new ZipOutputStream(msw);
			outStream.UseZip64 = UseZip64.On;

			outStream.IsStreamOwner = false;
			outStream.PutNextEntry(new ZipEntry("StripedMarlin"));
			outStream.WriteByte(89);
			outStream.Close();

			ms = new MemoryStream(msw.ToArray());
			using (ZipFile zf = new ZipFile(ms))
			{
				Assert.IsTrue(zf.TestArchive(true));
			}
		}

		/// <summary>
		/// Check that adding an entry with no data and Zip64 works OK
		/// </summary>
		[Test]
		[Category("Zip")]
		public void EntryWithNoDataAndZip64()
		{
			MemoryStream msw = new MemoryStreamWithoutSeek();
			ZipOutputStream outStream = new ZipOutputStream(msw);

			outStream.IsStreamOwner = false;
			ZipEntry ze = new ZipEntry("Striped Marlin");
			ze.ForceZip64();
			ze.Size = 0;
			outStream.PutNextEntry(ze);
			outStream.CloseEntry();
			outStream.Finish();
			outStream.Close();

			MemoryStream ms = new MemoryStream(msw.ToArray());
			using (ZipFile zf = new ZipFile(ms))
			{
				Assert.IsTrue(zf.TestArchive(true));
			}
		}
		/// <summary>
		/// Empty zip entries can be created and read?
		/// </summary>

		[Test]
		[Category("Zip")]
		public void EmptyZipEntries()
		{
			MemoryStream ms = new MemoryStream();
			ZipOutputStream outStream = new ZipOutputStream(ms);
			for (int i = 0; i < 10; ++i)
			{
				outStream.PutNextEntry(new ZipEntry(i.ToString()));
			}
			outStream.Finish();

			ms.Seek(0, SeekOrigin.Begin);

			ZipInputStream inStream = new ZipInputStream(ms);

			int extractCount = 0;
			ZipEntry entry;
			byte[] decompressedData = new byte[100];

			while ((entry = inStream.GetNextEntry()) != null)
			{
				while (true)
				{
					int numRead = inStream.Read(decompressedData, extractCount, decompressedData.Length);
					if (numRead <= 0)
					{
						break;
					}
					extractCount += numRead;
				}
			}
			inStream.Close();
			Assert.AreEqual(extractCount, 0, "No data should be read from empty entries");
		}

		/// <summary>
		/// Empty zips can be created and read?
		/// </summary>
		[Test]
		[Category("Zip")]
		public void CreateAndReadEmptyZip()
		{
			MemoryStream ms = new MemoryStream();
			ZipOutputStream outStream = new ZipOutputStream(ms);
			outStream.Finish();

			ms.Seek(0, SeekOrigin.Begin);

			ZipInputStream inStream = new ZipInputStream(ms);
			ZipEntry entry;
			while ((entry = inStream.GetNextEntry()) != null)
			{
				Assert.Fail("No entries should be found in empty zip");
			}
		}

		/// <summary>
		/// Base stream is closed when IsOwner is true ( default);
		/// </summary>
		[Test]
		public void BaseClosedWhenOwner()
		{
			MemoryStreamEx ms=new MemoryStreamEx();

			Assert.IsFalse(ms.IsClosed, "Underlying stream should NOT be closed");

			using( ZipOutputStream stream=new ZipOutputStream(ms) )
			{
				Assert.IsTrue(stream.IsStreamOwner, "Should be stream owner by default");
			}

			Assert.IsTrue(ms.IsClosed, "Underlying stream should be closed");
		}

		/// <summary>
		/// Check that base stream is not closed when IsOwner is false;
		/// </summary>
		[Test]
		public void BaseNotClosedWhenNotOwner()
		{
			MemoryStreamEx ms=new MemoryStreamEx();

			Assert.IsFalse(ms.IsClosed, "Underlying stream should NOT be closed");

			using( ZipOutputStream stream=new ZipOutputStream(ms) )
			{
				Assert.IsTrue(stream.IsStreamOwner, "Should be stream owner by default");
				stream.IsStreamOwner=false;
			}
			Assert.IsFalse(ms.IsClosed, "Underlying stream should still NOT be closed");
		}

		/// <summary>
		/// Check that base stream is not closed when IsOwner is false;
		/// </summary>
		[Test]
		public void BaseClosedAfterFailure()
		{
			MemoryStreamEx ms=new MemoryStreamEx(new byte[32]);

			Assert.IsFalse(ms.IsClosed, "Underlying stream should NOT be closed initially");
			bool blewUp = false;
			try
			{
				using( ZipOutputStream stream=new ZipOutputStream(ms) )
				{
					Assert.IsTrue(stream.IsStreamOwner, "Should be stream owner by default");
					try
					{
						stream.PutNextEntry(new ZipEntry("Tiny"));
						stream.Write(new byte[32], 0, 32);
					}
					finally
					{
						Assert.IsFalse(ms.IsClosed, "Stream should still not be closed.");
						stream.Close();
						Assert.Fail("Exception not thrown");
					}
				}
			}
			catch
			{
				blewUp = true;
			}

			Assert.IsTrue(blewUp, "Should have failed to write to stream");
			Assert.IsTrue(ms.IsClosed, "Underlying stream should be closed");
		}

		[Test]
		[Category("Zip")]
		public void WriteThroughput()
		{
			outStream_ = new ZipOutputStream(new NullStream());

			DateTime startTime = DateTime.Now;

			long target = 0x10000000;

			writeTarget_ = target;
			outStream_.PutNextEntry(new ZipEntry("0"));
			WriteTargetBytes();

			outStream_.Close();

			DateTime endTime = DateTime.Now;
			TimeSpan span = endTime - startTime;
			Console.WriteLine("Time {0} throughput {1} KB/Sec", span, (target / 1024) / span.TotalSeconds);
		}

		[Test]
		[Category("Zip")]
		[Category("Long Running")]
		public void SingleLargeEntry()
		{
			window_ = new WindowedStream(0x10000);
			outStream_ = new ZipOutputStream(window_);
			inStream_ = new ZipInputStream(window_);

			long target = 0x10000000;
			readTarget_ = writeTarget_ = target;

			Thread reader = new Thread(Reader);
			reader.Name = "Reader";

			Thread writer = new Thread(Writer);
			writer.Name = "Writer";

			DateTime startTime = DateTime.Now;
			reader.Start();
			writer.Start();

			writer.Join();
			reader.Join();

			DateTime endTime = DateTime.Now;
			TimeSpan span = endTime - startTime;
			Console.WriteLine("Time {0} throughput {1} KB/Sec", span, (target / 1024) / span.TotalSeconds);
		}

		void Reader()
		{
			const int Size = 8192;
			int readBytes = 1;
			byte[] buffer = new byte[Size];

			long passifierLevel = readTarget_ - 0x10000000;
			ZipEntry single = inStream_.GetNextEntry();

			Assert.AreEqual(single.Name, "CantSeek");
			Assert.IsTrue((single.Flags & (int)GeneralBitFlags.Descriptor) != 0);

			while ((readTarget_ > 0) && (readBytes > 0))
			{
				int count = Size;
				if (count > readTarget_)
				{
					count = (int)readTarget_;
				}

				readBytes = inStream_.Read(buffer, 0, count);
				readTarget_ -= readBytes;

				if (readTarget_ <= passifierLevel)
				{
					Console.WriteLine("Reader {0} bytes remaining", readTarget_);
					passifierLevel = readTarget_ - 0x10000000;
				}
			}

			Assert.IsTrue(window_.IsClosed, "Window should be closed");

			// This shouldnt read any data but should read the footer
			readBytes = inStream_.Read(buffer, 0, 1);
			Assert.AreEqual(0, readBytes, "Stream should be empty");
			Assert.AreEqual(0, window_.Length, "Window should be closed");
			inStream_.Close();
		}

		void WriteTargetBytes()
		{
			const int Size = 8192;

			byte[] buffer = new byte[Size];

			while (writeTarget_ > 0)
			{
				int thisTime = Size;
				if (thisTime > writeTarget_)
				{
					thisTime = (int)writeTarget_;
				}

				outStream_.Write(buffer, 0, thisTime);
				writeTarget_ -= thisTime;
			}
		}

		void Writer()
		{
			outStream_.PutNextEntry(new ZipEntry("CantSeek"));
			WriteTargetBytes();
			outStream_.Close();
		}

		WindowedStream window_;
		ZipOutputStream outStream_;
		ZipInputStream inStream_;
		long readTarget_;
		long writeTarget_;

	}

	[TestFixture]
	public class NameHandling : ZipBase
	{
		void TestFile(ZipNameTransform t, string original, string expected)
		{
			string transformed = t.TransformFile(original);
			Assert.AreEqual(expected, transformed, "Should be equal");
		}

		[Test]
		[Category("Zip")]
		public void Basic()
		{
			ZipNameTransform t = new ZipNameTransform();

			TestFile(t, "abcdef", "abcdef");
			TestFile(t, @"\\uncpath\d1\file1", "file1");
			TestFile(t, @"C:\absolute\file2", "absolute/file2");

			// This is ignored but could be converted to 'file3'
			TestFile(t, @"./file3", "./file3");

			// The following relative paths cant be handled and are ignored
			TestFile(t, @"../file3", "../file3");
			TestFile(t, @".../file3", ".../file3");

			// Trick filenames.
			TestFile(t, @".....file3", ".....file3");
		}

		[Test]
		[Category("Zip")]
		public void NameTransforms()
		{
			INameTransform t = new ZipNameTransform(@"C:\Slippery");
			Assert.AreEqual("Pongo/Directory/", t.TransformDirectory(@"C:\Slippery\Pongo\Directory"), "Value should be trimmed and converted");
			Assert.AreEqual("PoNgo/Directory/", t.TransformDirectory(@"c:\slipperY\PoNgo\Directory"), "Trimming should be case insensitive");
			Assert.AreEqual("slippery/Pongo/Directory/", t.TransformDirectory(@"d:\slippery\Pongo\Directory"), "Trimming should be case insensitive");
		}

		/// <summary>
		/// Test ZipEntry static file name cleaning methods
		/// </summary>
		[Test]
		[Category("Zip")]
		public void FilenameCleaning()
		{
			Assert.AreEqual(0, string.Compare(ZipEntry.CleanName("hello"), "hello"));
			Assert.AreEqual(0, string.Compare(ZipEntry.CleanName(@"z:\eccles"), "eccles"));
			Assert.AreEqual(0, string.Compare(ZipEntry.CleanName(@"\\server\share\eccles"), "eccles"));
			Assert.AreEqual(0, string.Compare(ZipEntry.CleanName(@"\\server\share\dir\eccles"), "dir/eccles"));
		}

		[Test]
		[Category("Zip")]
		public void PathalogicalNames()
		{
			string badName = ".*:\\zy3$";

			Assert.IsFalse(ZipNameTransform.IsValidName(badName));

			ZipNameTransform t = new ZipNameTransform();
			string result = t.TransformFile(badName);

			Assert.IsTrue(ZipNameTransform.IsValidName(result));
		}

	}

	/// <summary>
	/// This class contains test cases for Zip compression and decompression
	/// </summary>
	[TestFixture]
	public class GeneralHandling : ZipBase
	{
		void AddRandomDataToEntry(ZipOutputStream zipStream, int size)
		{
			if (size > 0)
			{
				byte[] data = new byte[size];
				System.Random rnd = new Random();
				rnd.NextBytes(data);

				zipStream.Write(data, 0, data.Length);
			}
		}

		void ExerciseZip(CompressionMethod method, int compressionLevel,
			int size, string password, bool canSeek)
		{
			byte[] originalData = null;
			byte[] compressedData = MakeInMemoryZip(ref originalData, method, compressionLevel, size, password, canSeek);

			MemoryStream ms = new MemoryStream(compressedData);
			ms.Seek(0, SeekOrigin.Begin);

			using (ZipInputStream inStream = new ZipInputStream(ms))
			{
				byte[] decompressedData = new byte[size];
				if (password != null)
				{
					inStream.Password = password;
				}

				ZipEntry entry2 = inStream.GetNextEntry();

				if ((entry2.Flags & 8) == 0)
				{
					Assert.AreEqual(size, entry2.Size, "Entry size invalid");
				}

				int currentIndex = 0;

				if (size > 0)
				{
					int count = decompressedData.Length;

					while (true)
					{
						int numRead = inStream.Read(decompressedData, currentIndex, count);
						if (numRead <= 0)
						{
							break;
						}
						currentIndex += numRead;
						count -= numRead;
					}
				}

				Assert.AreEqual(currentIndex, size, "Original and decompressed data different sizes");

				if (originalData != null)
				{
					for (int i = 0; i < originalData.Length; ++i)
					{
						Assert.AreEqual(decompressedData[i], originalData[i], "Decompressed data doesnt match original, compression level: " + compressionLevel);
					}
				}
			}
		}

		string DescribeAttributes(FieldAttributes attributes)
		{
			string att = string.Empty;
			if ((FieldAttributes.Public & attributes) != 0)
			{
				att = att + "Public,";
			}

			if ((FieldAttributes.Static & attributes) != 0)
			{
				att = att + "Static,";
			}

			if ((FieldAttributes.Literal & attributes) != 0)
			{
				att = att + "Literal,";
			}

			if ((FieldAttributes.HasDefault & attributes) != 0)
			{
				att = att + "HasDefault,";
			}

			if ((FieldAttributes.InitOnly & attributes) != 0)
			{
				att = att + "InitOnly,";
			}

			if ((FieldAttributes.Assembly & attributes) != 0)
			{
				att = att + "Assembly,";
			}

			if ((FieldAttributes.FamANDAssem & attributes) != 0)
			{
				att = att + "FamANDAssembly,";
			}

			if ((FieldAttributes.FamORAssem & attributes) != 0)
			{
				att = att + "FamORAssembly,";
			}

			if ((FieldAttributes.HasFieldMarshal & attributes) != 0)
			{
				att = att + "HasFieldMarshal,";
			}

			return att;
		}

		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(NotSupportedException))]
		public void UnsupportedCompressionMethod()
		{
			ZipEntry ze = new ZipEntry("HumblePie");
			System.Type type = typeof(CompressionMethod);
			//			System.Reflection.FieldInfo[] info = type.GetFields(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
			System.Reflection.FieldInfo[] info = type.GetFields();

			CompressionMethod aValue = CompressionMethod.Deflated;
			for (int i = 0; i < info.Length; i++)
			{
				System.Reflection.FieldAttributes attributes = info[i].Attributes;
				DescribeAttributes(attributes);
				if ((FieldAttributes.Static & attributes) != 0)
				{
					object obj = info[i].GetValue(null);
					string bb = obj.ToString();
					if (bb == null)
					{
						throw new Exception();
					}
				}
				string x = string.Format("The value of {0} is: {1}",
					info[i].Name, info[i].GetValue(aValue));
			}

			ze.CompressionMethod = CompressionMethod.BZip2;
		}

		/// <summary>
		/// Invalid passwords should be detected early if possible, seekable stream
		/// </summary>
		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(ZipException))]
		public void InvalidPasswordSeekable()
		{
			byte[] originalData = null;
			byte[] compressedData = MakeInMemoryZip(ref originalData, CompressionMethod.Deflated, 3, 500, "Hola", true);

			MemoryStream ms = new MemoryStream(compressedData);
			ms.Seek(0, SeekOrigin.Begin);

			byte[] buf2 = new byte[originalData.Length];
			int pos = 0;

			ZipInputStream inStream = new ZipInputStream(ms);
			inStream.Password = "redhead";

			ZipEntry entry2 = inStream.GetNextEntry();

			while (true)
			{
				int numRead = inStream.Read(buf2, pos, buf2.Length);
				if (numRead <= 0)
				{
					break;
				}
				pos += numRead;
			}
		}

		/// <summary>
		/// Check that GetNextEntry can handle the situation where part of the entry data has been read
		/// before the call is made.  ZipInputStream.CloseEntry wasnt handling this at all.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void ExerciseGetNextEntry()
		{
			byte[] compressedData = MakeInMemoryZip(
				true,
				new RuntimeInfo(CompressionMethod.Deflated, 9, 50, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 2, 50, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 50, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 2, 50, null, true),
				new RuntimeInfo(null, true),
				new RuntimeInfo(CompressionMethod.Stored, 2, 50, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 50, null, true)
				);

			MemoryStream ms = new MemoryStream(compressedData);
			ms.Seek(0, SeekOrigin.Begin);

			using (ZipInputStream inStream = new ZipInputStream(ms))
			{
				byte[] buffer = new byte[10];

				ZipEntry entry;
				while ((entry = inStream.GetNextEntry()) != null)
				{
					// Read a portion of the data, so GetNextEntry has some work to do.
					inStream.Read(buffer, 0, 10);
				}
			}
		}

		/// <summary>
		/// Invalid passwords should be detected early if possible, non seekable stream
		/// </summary>
		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(ZipException))]
		public void InvalidPasswordNonSeekable()
		{
			byte[] originalData = null;
			byte[] compressedData = MakeInMemoryZip(ref originalData, CompressionMethod.Deflated, 3, 500, "Hola", false);

			MemoryStream ms = new MemoryStream(compressedData);
			ms.Seek(0, SeekOrigin.Begin);

			byte[] buf2 = new byte[originalData.Length];
			int pos = 0;

			ZipInputStream inStream = new ZipInputStream(ms);
			inStream.Password = "redhead";

			ZipEntry entry2 = inStream.GetNextEntry();

			while (true)
			{
				int numRead = inStream.Read(buf2, pos, buf2.Length);
				if (numRead <= 0)
				{
					break;
				}
				pos += numRead;
			}
		}

		/// <summary>
		/// Adding an entry after the stream has Finished should fail
		/// </summary>
		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(InvalidOperationException))]
		public void AddEntryAfterFinish()
		{
			MemoryStream ms = new MemoryStream();
			ZipOutputStream s = new ZipOutputStream(ms);
			s.Finish();
			s.PutNextEntry(new ZipEntry("dummyfile.tst"));
		}

		/// <summary>
		/// Test setting file commment to a value that is too long
		/// </summary>
		[Test]
		[Category("Zip")]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void SetCommentOversize()
		{
			MemoryStream ms = new MemoryStream();
			ZipOutputStream s = new ZipOutputStream(ms);
			s.SetComment(new String('A', 65536));
		}

		/// <summary>
		/// Check that simply closing ZipOutputStream finishes the zip correctly
		/// </summary>
		[Test]
		[Category("Zip")]
		public void CloseOnlyHandled()
		{
			MemoryStream ms = new MemoryStream();
			ZipOutputStream s = new ZipOutputStream(ms);
			s.PutNextEntry(new ZipEntry("dummyfile.tst"));
			s.Close();

			Assert.IsTrue(s.IsFinished, "Output stream should be finished");
		}

		/// <summary>
		/// Basic compress/decompress test, no encryption, size is important here as its big enough
		/// to force multiple write to output which was a problem...
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicDeflated()
		{
			for (int i = 0; i <= 9; ++i)
			{
				ExerciseZip(CompressionMethod.Deflated, i, 50000, null, true);
			}
		}

		/// <summary>
		/// Basic compress/decompress test, no encryption, size is important here as its big enough
		/// to force multiple write to output which was a problem...
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicDeflatedNonSeekable()
		{
			for (int i = 0; i <= 9; ++i)
			{
				ExerciseZip(CompressionMethod.Deflated, i, 50000, null, false);
			}
		}

		/// <summary>
		/// Basic stored file test, no encryption.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicStored()
		{
			ExerciseZip(CompressionMethod.Stored, 0, 50000, null, true);
		}

		/// <summary>
		/// Basic stored file test, no encryption, non seekable output
		/// NOTE this gets converted to deflate level 0
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicStoredNonSeekable()
		{
			ExerciseZip(CompressionMethod.Stored, 0, 50000, null, false);
		}

		/// <summary>
		/// Basic compress/decompress test, with encryption, size is important here as its big enough
		/// to force multiple write to output which was a problem...
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicDeflatedEncrypted()
		{
			for (int i = 0; i <= 9; ++i)
			{
				ExerciseZip(CompressionMethod.Deflated, i, 50000, "Rosebud", true);
			}
		}

		/// <summary>
		/// Basic compress/decompress test, with encryption, size is important here as its big enough
		/// to force multiple write to output which was a problem...
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicDeflatedEncryptedNonSeekable()
		{
			for (int i = 0; i <= 9; ++i)
			{
				ExerciseZip(CompressionMethod.Deflated, i, 50000, "Rosebud", false);
			}
		}

		[Test]
		[Category("Zip")]
		public void SkipEncryptedEntriesWithoutSettingPassword()
		{
			byte[] compressedData = MakeInMemoryZip(true,
				new RuntimeInfo("1234", true),
				new RuntimeInfo(CompressionMethod.Deflated, 2, 1, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 1, "1234", true),
				new RuntimeInfo(CompressionMethod.Deflated, 2, 1, null, true),
				new RuntimeInfo(null, true),
				new RuntimeInfo(CompressionMethod.Stored, 2, 1, "4321", true),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 1, "1234", true)
				);

			MemoryStream ms = new MemoryStream(compressedData);
			ZipInputStream inStream = new ZipInputStream(ms);

			ZipEntry entry;
			while ((entry = inStream.GetNextEntry()) != null)
			{
			}

			inStream.Close();
		}

		[Test]
		[Category("Zip")]
		public void MixedEncryptedAndPlain()
		{
			byte[] compressedData = MakeInMemoryZip(true,
				new RuntimeInfo(CompressionMethod.Deflated, 2, 1, null, true),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 1, "1234", false),
				new RuntimeInfo(CompressionMethod.Deflated, 2, 1, null, false),
				new RuntimeInfo(CompressionMethod.Deflated, 9, 1, "1234", true)
				);

			MemoryStream ms = new MemoryStream(compressedData);
			using (ZipInputStream inStream = new ZipInputStream(ms))
			{
				inStream.Password = "1234";

				int extractCount = 0;
				int extractIndex = 0;
				ZipEntry entry;
				byte[] decompressedData = new byte[100];

				while ((entry = inStream.GetNextEntry()) != null)
				{
					extractCount = decompressedData.Length;
					extractIndex = 0;
					while (true)
					{
						int numRead = inStream.Read(decompressedData, extractIndex, extractCount);
						if (numRead <= 0)
						{
							break;
						}
						extractIndex += numRead;
						extractCount -= numRead;
					}
				}
				inStream.Close();
			}
		}

		/// <summary>
		/// Basic stored file test, with encryption.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicStoredEncrypted()
		{
			ExerciseZip(CompressionMethod.Stored, 0, 50000, "Rosebud", true);
		}

		/// <summary>
		/// Basic stored file test, with encryption, non seekable output.
		/// NOTE this gets converted deflate level 0
		/// </summary>
		[Test]
		[Category("Zip")]
		public void BasicStoredEncryptedNonSeekable()
		{
			ExerciseZip(CompressionMethod.Stored, 0, 50000, "Rosebud", false);
		}

		/// <summary>
		/// Check that when the output stream cannot seek that requests for stored
		/// are in fact converted to defalted level 0
		/// </summary>
		[Test]
		[Category("Zip")]
		public void StoredNonSeekableConvertToDeflate()
		{
			MemoryStreamWithoutSeek ms = new MemoryStreamWithoutSeek();

			ZipOutputStream outStream = new ZipOutputStream(ms);
			outStream.SetLevel(8);
			Assert.AreEqual(8, outStream.GetLevel(), "Compression level invalid");

			ZipEntry entry = new ZipEntry("1.tst");
			entry.CompressionMethod = CompressionMethod.Stored;
			outStream.PutNextEntry(entry);
			Assert.AreEqual(0, outStream.GetLevel(), "Compression level invalid");

			AddRandomDataToEntry(outStream, 100);
			entry = new ZipEntry("2.tst");
			entry.CompressionMethod = CompressionMethod.Deflated;
			outStream.PutNextEntry(entry);
			Assert.AreEqual(8, outStream.GetLevel(), "Compression level invalid");
			AddRandomDataToEntry(outStream, 100);

			outStream.Close();
		}

		/// <summary>
		/// Check that adding more than the 2.0 limit for entry numbers is detected and handled
		/// </summary>
		[Test]
		[Category("Zip")]
		[Category("Long Running")]
		public void Stream_64KPlusOneEntries()
		{
			const int target = 65537;
			MemoryStream ms = new MemoryStream();
			using (ZipOutputStream s = new ZipOutputStream(ms))
			{

				for (int i = 0; i < target; ++i)
				{
					s.PutNextEntry(new ZipEntry("dummyfile.tst"));
				}

				s.Finish();
				ms.Seek(0, SeekOrigin.Begin);
				using (ZipFile zipFile = new ZipFile(ms))
				{
					Assert.AreEqual(target, zipFile.Count, "Incorrect number of entries stored");
				}
			}
		}

		/// <summary>
		/// Check that Unicode filename support works.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void Stream_UnicodeEntries()
		{
			MemoryStream ms = new MemoryStream();
			using (ZipOutputStream s = new ZipOutputStream(ms))
			{
				s.IsStreamOwner = false;

				string sampleName = "\u03A5\u03d5\u03a3";
				ZipEntry sample = new ZipEntry(sampleName);
				sample.IsUnicodeText = true;
				s.PutNextEntry(sample);

				s.Finish();
				ms.Seek(0, SeekOrigin.Begin);

				using (ZipInputStream zis = new ZipInputStream(ms))
				{
					ZipEntry ze = zis.GetNextEntry();
					Assert.AreEqual(sampleName, ze.Name, "Expected name to match original");
					Assert.IsTrue(ze.IsUnicodeText, "Expected IsUnicodeText flag to be set");
				}
			}
		}

		[Test]
		[Category("Zip")]
		[Category("CreatesTempFile")]
		public void PartialStreamClosing()
		{
			string tempFile = GetTempFilePath();
			Assert.IsNotNull(tempFile, "No permission to execute this test?");

			if (tempFile != null)
			{
				tempFile = Path.Combine(tempFile, "SharpZipTest.Zip");
				MakeZipFile(tempFile, new String[] { "Farriera", "Champagne", "Urban myth" }, 10, "Aha");

				using (ZipFile zipFile = new ZipFile(tempFile))
				{

					Stream stream = zipFile.GetInputStream(0);
					stream.Close();

					stream = zipFile.GetInputStream(1);
					zipFile.Close();
				}
				File.Delete(tempFile);
			}
		}

		void TestLargeZip(string tempFile, int targetFiles)
		{
			const int BlockSize = 4096;

			byte[] data = new byte[BlockSize];
			byte nextValue = 0;
			for (int i = 0; i < BlockSize; ++i)
			{
				nextValue = ScatterValue(nextValue);
				data[i] = nextValue;
			}

			using (ZipFile zFile = new ZipFile(tempFile))
			{
				Assert.AreEqual(targetFiles, zFile.Count);
				byte[] readData = new byte[BlockSize];
				int readIndex;
				foreach (ZipEntry ze in zFile) {
					Stream s = zFile.GetInputStream(ze);
					readIndex = 0;
					while (readIndex < readData.Length) {
						readIndex += s.Read(readData, readIndex, data.Length - readIndex);
					}

					for (int ii = 0; ii < BlockSize; ++ii) {
						Assert.AreEqual(data[ii], readData[ii]);
					}
				}
				zFile.Close();
			}
		}

		//      [Test]
		//      [Category("Zip")]
		//      [Category("CreatesTempFile")]
		public void TestLargeZipFile()
		{
			string tempFile = @"g:\\tmp";
			tempFile = Path.Combine(tempFile, "SharpZipTest.Zip");
			TestLargeZip(tempFile, 8100);
		}

		//      [Test]
		//      [Category("Zip")]
		//      [Category("CreatesTempFile")]
		public void MakeLargeZipFile()
		{
			string tempFile = null;
			try {
				//            tempFile = Path.GetTempPath();
				tempFile = @"g:\\tmp";
			}
			catch (SecurityException) {
			}

			Assert.IsNotNull(tempFile, "No permission to execute this test?");

			if (tempFile != null) {
				const int blockSize = 4096;

				byte[] data = new byte[blockSize];
				byte nextValue = 0;
				for (int i = 0; i < blockSize; ++i) {
					nextValue = ScatterValue(nextValue);
					data[i] = nextValue;
				}

				tempFile = Path.Combine(tempFile, "SharpZipTest.Zip");
				Console.WriteLine("Starting at {0}", DateTime.Now);
				try {
					//               MakeZipFile(tempFile, new String[] {"1", "2" }, int.MaxValue, "C1");
					using (FileStream fs = File.Create(tempFile)) {
						ZipOutputStream zOut = new ZipOutputStream(fs);
						zOut.SetLevel(4);
						const int TargetFiles = 8100;
						for (int i = 0; i < TargetFiles; ++i) {
							ZipEntry e = new ZipEntry(i.ToString());
							e.CompressionMethod = CompressionMethod.Stored;

							zOut.PutNextEntry(e);
							for (int block = 0; block < 128; ++block) {
								zOut.Write(data, 0, blockSize);
							}
						}
						zOut.Close();
						fs.Close();

						TestLargeZip(tempFile, TargetFiles);
					}
				}
				finally
				{
					Console.WriteLine("Starting at {0}", DateTime.Now);
					//               File.Delete(tempFile);
				}
			}
		}

		/// <summary>
		/// Test for handling of zero lengths in compression using a formatter which
		/// will request reads of zero length...
		/// </summary>
		[Test]
		[Category("Zip")]
		public void SerializedObjectZeroLength()
		{
			object data = new byte[0];
			// Thisa wont be zero length here due to serialisation.
			byte[] zipped = ZipZeroLength(data);
			object o = UnZipZeroLength(zipped);

			byte[] returned = o as byte[];

			Assert.IsNotNull(returned, "Expected a byte[]");
			Assert.AreEqual(0, returned.Length);
		}

		/// <summary>
		/// Test for handling of serialized reference and value objects.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void SerializedObject()
		{
			DateTime sampleDateTime = new DateTime(1853, 8, 26);
			object data = (object)sampleDateTime;
			byte[] zipped = ZipZeroLength(data);
			object rawObject = UnZipZeroLength(zipped);

			DateTime returnedDateTime = (DateTime)rawObject;

			Assert.AreEqual(sampleDateTime, returnedDateTime);

			string sampleString = "Mary had a giant cat it ears were green and smelly";
			zipped = ZipZeroLength(sampleString);

			rawObject = UnZipZeroLength(zipped);

			string returnedString = rawObject as string;

			Assert.AreEqual(sampleString, returnedString);
		}

		byte[] ZipZeroLength(object data)
		{
			BinaryFormatter formatter = new BinaryFormatter();
			MemoryStream memStream = new MemoryStream();

			using (ZipOutputStream zipStream = new ZipOutputStream(memStream)) {
				zipStream.PutNextEntry(new ZipEntry("data"));
				formatter.Serialize(zipStream, data);
				zipStream.CloseEntry();
				zipStream.Close();
			}

			byte[] result = memStream.ToArray();
			memStream.Close();

			return result;
		}

		object UnZipZeroLength(byte[] zipped)
		{
			if (zipped == null)
			{
				return null;
			}

			object result = null;
			BinaryFormatter formatter = new BinaryFormatter();
			MemoryStream memStream = new MemoryStream(zipped);
			using (ZipInputStream zipStream = new ZipInputStream(memStream))
			{
				ZipEntry zipEntry = zipStream.GetNextEntry();
				if (zipEntry != null)
				{
					result = formatter.Deserialize(zipStream);
				}
				zipStream.Close();
			}
			memStream.Close();

			return result;
		}

		void CheckNameConversion(string toCheck)
		{
			byte[] intermediate = ZipConstants.ConvertToArray(toCheck);
			string final = ZipConstants.ConvertToString(intermediate);

			Assert.AreEqual(toCheck, final, "Expected identical result");
		}

		[Test]
		[Category("Zip")]
		public void NameConversion()
		{
			CheckNameConversion("Hello");
			CheckNameConversion("a/b/c/d/e/f/g/h/SomethingLikeAnArchiveName.txt");
		}

		[Test]
		[Category("Zip")]
		public void UnicodeNameConversion()
		{
			ZipConstants.DefaultCodePage = 850;
			string sample = "Hello world";

			byte[] rawData = Encoding.ASCII.GetBytes(sample);

			string converted = ZipConstants.ConvertToStringExt(0, rawData);
			Assert.AreEqual(sample, converted);

			converted = ZipConstants.ConvertToStringExt((int)GeneralBitFlags.UnicodeText, rawData);
			Assert.AreEqual(sample, converted);

			// This time use some greek characters
			sample = "\u03A5\u03d5\u03a3";
			rawData = Encoding.UTF8.GetBytes(sample);

			converted = ZipConstants.ConvertToStringExt((int)GeneralBitFlags.UnicodeText, rawData);
			Assert.AreEqual(sample, converted);
		}

		/// <summary>
		/// Regression test for problem where the password check would fail for an archive whose
		/// date was updated from the extra data.
		/// This applies to archives where the crc wasnt know at the time of encryption.
		/// The date of the entry is used in its place.
		/// </summary>
		[Test]
		[Category("Zip")]
		public void PasswordCheckingWithDateInExtraData()
		{
			MemoryStream ms = new MemoryStream();
			DateTime checkTime = new DateTime(2010, 10, 16, 0, 3, 28);

			using (ZipOutputStream zos = new ZipOutputStream(ms))
			{
				zos.IsStreamOwner = false;
				zos.Password = "secret";
				ZipEntry ze = new ZipEntry("uno");
				ze.DateTime = new DateTime(1998, 6, 5, 4, 3, 2);

				ZipExtraData zed = new ZipExtraData();

				zed.StartNewEntry();

				zed.AddData(1);

				TimeSpan delta = checkTime.ToUniversalTime() - new System.DateTime(1970, 1, 1, 0, 0, 0).ToUniversalTime();
				int seconds = (int)delta.TotalSeconds;
				zed.AddLeInt(seconds);
				zed.AddNewEntry(0x5455);

				ze.ExtraData = zed.GetEntryData();
				zos.PutNextEntry(ze);
				zos.WriteByte(54);
			}

			ms.Position = 0;
			using (ZipInputStream zis = new ZipInputStream(ms))
			{
				zis.Password = "secret";
				ZipEntry uno = zis.GetNextEntry();
				byte theByte = (byte)zis.ReadByte();
				Assert.AreEqual(54, theByte);
				Assert.AreEqual(-1, zis.ReadByte());
				Assert.AreEqual(checkTime, uno.DateTime);
			}
		}
	}

	[TestFixture]
	public class ZipExtraDataHandling : ZipBase
	{
		/// <summary>
		/// Extra data for separate entries should be unique to that entry
		/// </summary>
		[Test]
		[Category("Zip")]
		public void IsDataUnique()
		{
			ZipEntry a = new ZipEntry("Basil");
			byte[] extra = new byte[4];
			extra[0] = 27;
			a.ExtraData = extra;

			ZipEntry b = (ZipEntry)a.Clone();
			b.ExtraData[0] = 89;
			Assert.IsTrue(b.ExtraData[0] != a.ExtraData[0], "Extra data not unique " + b.ExtraData[0] + " " + a.ExtraData[0]);

			ZipEntry c = (ZipEntry)a.Clone();
			c.ExtraData[0] = 45;
			Assert.IsTrue(a.ExtraData[0] != c.ExtraData[0], "Extra data not unique " + a.ExtraData[0] + " " + c.ExtraData[0]);
		}

		[Test]
		[Category("Zip")]
		public void ExceedSize()
		{
			ZipExtraData zed = new ZipExtraData();
			byte[] buffer = new byte[65506];
			zed.AddEntry(1, buffer);
			Assert.AreEqual(65510, zed.Length);
			zed.AddEntry(2, new byte[21]);
			Assert.AreEqual(65535, zed.Length);

			bool caught = false;
			try
			{
				zed.AddEntry(3, null);
			}
			catch
			{
				caught = true;
			}
			Assert.IsTrue(caught, "Expected an exception when max size exceeded");
			Assert.AreEqual(65535, zed.Length);

			zed.Delete(2);
			Assert.AreEqual(65510, zed.Length);

			caught = false;
			try
			{
				zed.AddEntry(2, new byte[22]);
			}
			catch
			{
				caught = true;
			}
			Assert.IsTrue(caught, "Expected an exception when max size exceeded");
			Assert.AreEqual(65510, zed.Length);
		}

		[Test]
		[Category("Zip")]
		public void Deleting()
		{
			ZipExtraData zed = new ZipExtraData();
			Assert.AreEqual(0, zed.Length);

			// Tag 1 Totoal length 10
			zed.AddEntry(1, new byte[] { 10, 11, 12, 13, 14, 15 });
			Assert.AreEqual(10, zed.Length, "Length should be 10");
			Assert.AreEqual(10, zed.GetEntryData().Length, "Data length should be 10");

			// Tag 2 total length  9
			zed.AddEntry(2, new byte[] { 20, 21, 22, 23, 24 });
			Assert.AreEqual(19, zed.Length, "Length should be 19");
			Assert.AreEqual(19, zed.GetEntryData().Length, "Data length should be 19");

			// Tag 3 Total Length 6
			zed.AddEntry(3, new byte[] { 30, 31 });
			Assert.AreEqual(25, zed.Length, "Length should be 25");
			Assert.AreEqual(25, zed.GetEntryData().Length, "Data length should be 25");

			zed.Delete(2);
			Assert.AreEqual(16, zed.Length, "Length should be 16");
			Assert.AreEqual(16, zed.GetEntryData().Length, "Data length should be 16");

			// Tag 2 total length  9
			zed.AddEntry(2, new byte[] { 20, 21, 22, 23, 24 });
			Assert.AreEqual(25, zed.Length, "Length should be 25");
			Assert.AreEqual(25, zed.GetEntryData().Length, "Data length should be 25");

			zed.AddEntry(3, null);
			Assert.AreEqual(23, zed.Length, "Length should be 23");
			Assert.AreEqual(23, zed.GetEntryData().Length, "Data length should be 23");
		}

		[Test]
		[Category("Zip")]
		public void BasicOperations()
		{
			ZipExtraData zed = new ZipExtraData(null);
			Assert.AreEqual(0, zed.Length);

			zed = new ZipExtraData(new byte[] { 1, 0, 0, 0 });
			Assert.AreEqual(4, zed.Length, "A length should be 4");

			ZipExtraData zed2 = new ZipExtraData();
			Assert.AreEqual(0, zed2.Length);

			zed2.AddEntry(1, new byte[] { });

			byte[] data = zed.GetEntryData();
			for (int i = 0; i < data.Length; ++i)
			{
				Assert.AreEqual(zed2.GetEntryData()[i], data[i]);
			}

			Assert.AreEqual(4, zed2.Length, "A1 length should be 4");

			bool findResult = zed.Find(2);
			Assert.IsFalse(findResult, "A - Shouldnt find tag 2");

			findResult = zed.Find(1);
			Assert.IsTrue(findResult, "A - Should find tag 1");
			Assert.AreEqual(0, zed.ValueLength, "A- Length of entry should be 0");
			Assert.AreEqual(-1, zed.ReadByte());
			Assert.AreEqual(0, zed.GetStreamForTag(1).Length, "A - Length of stream should be 0");

			zed = new ZipExtraData(new byte[] { 1, 0, 3, 0, 1, 2, 3 });
			Assert.AreEqual(7, zed.Length, "Expected a length of 7");

			findResult = zed.Find(1);
			Assert.IsTrue(findResult, "B - Should find tag 1");
			Assert.AreEqual(3, zed.ValueLength, "B - Length of entry should be 3");
			for (int i = 1; i <= 3; ++i)
			{
				Assert.AreEqual(i, zed.ReadByte());
			}
			Assert.AreEqual(-1, zed.ReadByte());

			Stream s = zed.GetStreamForTag(1);
			Assert.AreEqual(3, s.Length, "B.1 Stream length should be 3");
			for (int i = 1; i <= 3; ++i)
			{
				Assert.AreEqual(i, s.ReadByte());
			}
			Assert.AreEqual(-1, s.ReadByte());

			zed = new ZipExtraData(new byte[] { 1, 0, 3, 0, 1, 2, 3, 2, 0, 1, 0, 56 });
			Assert.AreEqual(12, zed.Length, "Expected a length of 12");

			findResult = zed.Find(1);
			Assert.IsTrue(findResult, "C.1 - Should find tag 1");
			Assert.AreEqual(3, zed.ValueLength, "C.1 - Length of entry should be 3");
			for (int i = 1; i <= 3; ++i)
			{
				Assert.AreEqual(i, zed.ReadByte());
			}
			Assert.AreEqual(-1, zed.ReadByte());

			findResult = zed.Find(2);
			Assert.IsTrue(findResult, "C.2 - Should find tag 2");
			Assert.AreEqual(1, zed.ValueLength, "C.2 - Length of entry should be 1");
			Assert.AreEqual(56, zed.ReadByte());
			Assert.AreEqual(-1, zed.ReadByte());

			s = zed.GetStreamForTag(2);
			Assert.AreEqual(1, s.Length);
			Assert.AreEqual(56, s.ReadByte());
			Assert.AreEqual(-1, s.ReadByte());

			zed = new ZipExtraData();
			zed.AddEntry(7, new byte[] { 33, 44, 55 });
			findResult = zed.Find(7);
			Assert.IsTrue(findResult, "Add.1 should find new tag");
			Assert.AreEqual(3, zed.ValueLength, "Add.1 length should be 3");
			Assert.AreEqual(33, zed.ReadByte());
			Assert.AreEqual(44, zed.ReadByte());
			Assert.AreEqual(55, zed.ReadByte());
			Assert.AreEqual(-1, zed.ReadByte());

			zed.AddEntry(7, null);
			findResult = zed.Find(7);
			Assert.IsTrue(findResult, "Add.2 should find new tag");
			Assert.AreEqual(0, zed.ValueLength, "Add.2 length should be 0");

			zed.StartNewEntry();
			zed.AddData(0xae);
			zed.AddNewEntry(55);

			findResult = zed.Find(55);
			Assert.IsTrue(findResult, "Add.3 should find new tag");
			Assert.AreEqual(1, zed.ValueLength, "Add.3 length should be 1");
			Assert.AreEqual(0xae, zed.ReadByte());
			Assert.AreEqual(-1, zed.ReadByte());

			zed = new ZipExtraData();
			zed.StartNewEntry();
			zed.AddLeLong(0);
			zed.AddLeLong(-4);
			zed.AddLeLong(-1);
			zed.AddLeLong(long.MaxValue);
			zed.AddLeLong(long.MinValue);
			zed.AddLeLong(0x123456789ABCDEF0);
			zed.AddLeLong(unchecked((long)0xFEDCBA9876543210));
			zed.AddNewEntry(567);

			s = zed.GetStreamForTag(567);
			long longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(0, longValue, "Expected long value of zero");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(-4, longValue, "Expected long value of -4");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(-1, longValue, "Expected long value of -1");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(long.MaxValue, longValue, "Expected long value of MaxValue");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(long.MinValue, longValue, "Expected long value of MinValue");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(0x123456789abcdef0, longValue, "Expected long value of MinValue");

			longValue = ReadLong(s);
			Assert.AreEqual(longValue, zed.ReadLong(), "Read/stream mismatch");
			Assert.AreEqual(unchecked((long)0xFEDCBA9876543210), longValue, "Expected long value of MinValue");
		}

		[Test]
		[Category("Zip")]
		public void UnreadCountValid()
		{
			ZipExtraData zed = new ZipExtraData(new byte[] { 1, 0, 0, 0 });
			Assert.AreEqual(4, zed.Length, "Length should be 4");
			Assert.IsTrue(zed.Find(1), "Should find tag 1");
			Assert.AreEqual(0, zed.UnreadCount);

			// seven bytes
			zed = new ZipExtraData(new byte[] { 1, 0, 7, 0, 1, 2, 3, 4, 5, 6, 7 });
			Assert.IsTrue(zed.Find(1), "Should find tag 1");

			for (int i = 0; i < 7; ++i)
			{
				Assert.AreEqual(7 - i, zed.UnreadCount);
				zed.ReadByte();
			}

			zed.ReadByte();
			Assert.AreEqual(0, zed.UnreadCount);
		}

		[Test]
		[Category("Zip")]
		public void Skipping()
		{
			ZipExtraData zed = new ZipExtraData(new byte[] { 1, 0, 7, 0, 1, 2, 3, 4, 5, 6, 7 });
			Assert.AreEqual(11, zed.Length, "Length should be 11");
			Assert.IsTrue(zed.Find(1), "Should find tag 1");

			Assert.AreEqual(7, zed.UnreadCount);
			Assert.AreEqual(4, zed.CurrentReadIndex);

			zed.ReadByte();
			Assert.AreEqual(6, zed.UnreadCount);
			Assert.AreEqual(5, zed.CurrentReadIndex);

			zed.Skip(1);
			Assert.AreEqual(5, zed.UnreadCount);
			Assert.AreEqual(6, zed.CurrentReadIndex);

			zed.Skip(-1);
			Assert.AreEqual(6, zed.UnreadCount);
			Assert.AreEqual(5, zed.CurrentReadIndex);

			zed.Skip(6);
			Assert.AreEqual(0, zed.UnreadCount);
			Assert.AreEqual(11, zed.CurrentReadIndex);

			bool exceptionCaught = false;

			try
			{
				zed.Skip(1);
			}
			catch (ZipException)
			{
				exceptionCaught = true;
			}
			Assert.IsTrue(exceptionCaught, "Should fail to skip past end");

			Assert.AreEqual(0, zed.UnreadCount);
			Assert.AreEqual(11, zed.CurrentReadIndex);

			zed.Skip(-7);
			Assert.AreEqual(7, zed.UnreadCount);
			Assert.AreEqual(4, zed.CurrentReadIndex);

			try
			{
				zed.Skip(-1);
			}
			catch (ZipException)
			{
				exceptionCaught = true;
			}
			Assert.IsTrue(exceptionCaught, "Should fail to skip before beginning");

		}

		[Test]
		[Category("Zip")]
		public void ReadOverrunLong()
		{
			ZipExtraData zed = new ZipExtraData(new byte[] { 1, 0, 0, 0 });
			Assert.AreEqual(4, zed.Length, "Length should be 4");
			Assert.IsTrue(zed.Find(1), "Should find tag 1");

			// Empty Tag
			bool exceptionCaught = false;
			try
			{
				zed.ReadLong();
			}
			catch (ZipException)
			{
				exceptionCaught = true;
			}
			Assert.IsTrue(exceptionCaught, "Expected EOS exception");

			// seven bytes
			zed = new ZipExtraData(new byte[] { 1, 0, 7, 0, 1, 2, 3, 4, 5, 6, 7 });
			Assert.IsTrue(zed.Find(1), "Should find tag 1");

			exceptionCaught = false;
			try
			{
				zed.ReadLong();
			}
			catch (ZipException)
			{
				exceptionCaught = true;
			}
			Assert.IsTrue(exceptionCaught, "Expected EOS exception");

			zed = new ZipExtraData(new byte[] { 1, 0, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9Fº5€»5€»5 »5@ñ¹5ò¹5Àò¹5àó¹5ğÕ©5€»5Àø¹5àÎ­5 §ç5€€»5@Õ©5 µ 5P€»5@Ô¢5 ô¹5°ô¹5 º5ø¹5 ÷¹5€º5P!º5Ğ€»5°Fº5à•º5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5Àh»5 N»5 â®5àÎ­5PNí5@aÚ50;ˆ5°ß®5 M»50O»5ğM»5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5K»5º5ğ€»5»5À!º5Fº5€»5€»5 »5pº5Àº5ğº5º5ğÕ©5€»5`"º5àÎ­5 §ç5€€»5PNí5@aÚ50;ˆ5`º5 º5@Õ©5 µ 5P€»5@Ô¢5Pº5àº5 º5ø¹5°º5€º5P!º5Ğ€»5°Fº5à•º5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5@K»5p:º5ğ€»5»5À!º5Fº5€»5€»5 »5P=º5 >º5Ğ>º5ğ?º5ğÕ©5€»5€Fº5àÎ­5 §ç5€€»5PNí5@aÚ50;ˆ5@<º5 <º5@Õ©5 µ 5P€»5@Ô¢50@º5À@º5 º5ø¹5°Cº5€º5P!º5Ğ€»5°Fº5à•º5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5pK»5@^º5ğ€»5»5 mº5Poº5€»5€»5 »5 aº5pbº5 bº5Àcº5ğÕ©5€»5oº5àÎ­5 §ç5€€»5PNí5@aÚ50;ˆ5`º5Ğ_º5@Õ©5 µ 5P€»5@Ô¢5 dº5dº5Àfº5Ğhº5€fº5Àjº5àlº5Ğ€»5°Fº5à•º5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5ğh»5àQ»5 â®5àÎ­5PNí5@aÚ50;ˆ5°ß®5€P»5ĞP»5@Q»5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5 K»5p‡º5@Ô¢5»5À“º5€•º5€»5€»5 »5PŠº5 ‹º5Ğ‹º5ğŒº5ğÕ©5€»5°•º5àÎ­5 §ç5€€»5PNí5@aÚ50;ˆ5@‰º5 ‰º5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5 i»5pT»5 â®5àÎ­5PNí5@aÚ50;ˆ5°ß®5PS»5 S»5ğS»5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5ĞK»5ğ¯º5ğ€»5»5Ğ½º5PÀº5€»5€»5 »5ğ²º5`´º5´º5°µº5ğÕ©5€»5Àº5àÎ­5 §ç5€€»5@Õ©5 µ 5P€»5@Ô¢5ğµº5€¶º5»º5P»º5ğ¸º5½º59»5Ğ€»5°Fº5à•º5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5 L»5×º5 â®5àÎ­5PNí5@aÚ50;ˆ5 İ6 Öº5 ¨º5ğÖº5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ50L»50ßº5ğ€»5»5àéº5ìº5€»5€»5 »5âº5`ãº5ãº5°äº5ğÕ©5€»5pìº5àÎ­5 §ç5€€»5@Õ©5 µ 5P€»5@Ô¢5ğäº5€åº50»5p»5pçº5€éº5»5Ğ€»5°Fº5à•º5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5Pi»5PW»5 â®5àÎ­5PNí5@aÚ50;ˆ5°ß®5àU»50V»5°V»5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5`L»5 »5ğ€»5»5àéº5ìº5€»5€»5 »5€	»5Ğ
»5 »5 »5ğÕ©5€»5ğ»5àÎ­5 §ç5€€»5@Õ©5 µ 5P€»5@Ô¢5`»5ğ»50»5p»5Ğ»5€éº5»5Ğ€»5°Fº5à•º5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5@;ˆ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5Ài‹5Ph‹5àÎ­5Ğwƒ5ğoƒ5L»5°-»5ğ€»5»5Ğ½º5PÀº5€»5€»5 »5°0»5 2»5P2»5p3»5ğÕ©5€»5P9»5àÎ­5 §ç5€€»5PNí5@aÚ50;ˆ5€/»5@/»5@Õ©5 µ 5P€»5@Ô¢5°3»5@4»5»º5P»º56»5½º59»5Ğ€»5°Fº5à•º5    P²Î5àMí5ÀXØ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5`»5 N»5 â®5àÎ­5PNí5Ğ¶Ú5 Ní5°ß®5 M»50O»5ğM»5P²Î5àMí5ÀXØ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5»5àQ»5 â®5àÎ­5PNí5Ğ¶Ú5 Ní5°ß®5€P»5ĞP»5@Q»5P²Î5àMí5ÀXØ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5À»5pT»5 â®5àÎ­5PNí5Ğ¶Ú5 Ní5°ß®5PS»5 S»5ğS»5P²Î5àMí5ÀXØ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5ğ»5PW»5 â®5àÎ­5PNí5Ğ¶Ú5 Ní5°ß®5àU»50V»5°V»5P²Î5àMí5ÀXØ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ê®5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5€i‹5'Ë5àÎ­5Ğwƒ5ğoƒ5 €»5×º5 â®5àÎ­5PNí5Ğ¶Ú5 Ní5 İ6 Öº5 ¨º5ğÖº5Y u k o n S e r v e r C o n t a i n e r _ C r y p t     e n c r y p t e d _ f i l e     n a m e t a b l e   c o n f i g f i l e     % X % X % X % X % X         e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d s \ p f s s f i l e s y s . c p p     C o n f i g F i l e \ V e r s i o n H i g h     C o n f i g F i l e \ V e r s i o n L o w   C o n f i g F i l e \ I s E n c r y p t e d     C o n f i g F i l e \ C S P N a m e     C o n f i g F i l e \ C S P T y p e     C o n f i g F i l e \ E n c r y p t i o n A l g o r i t h m     C o n f i g F i l e \ H a s h A l g o r i t h m     C o n f i g F i l e \ K e y L e n g t h     n a m e t a b l e . t m p   P F S S D i r e c t o r y : : C r e a t e D i r     P F S S D i r e c t o r y : : R e n a m e D i r     P F S S D i r e c t o r y : : D e l e t e D i r     P F S S D i r e c t o r y : : O p e n F i l e   P F S S D i r e c t o r y : : R e n a m e F i l e   P F S S D i r e c t o r y : : C o p y F i l e W     P F S S D i r e c t o r y : : M o v e F i l e W     P F S S D i r e c t o r y : : D e l e t e F i l e W     P F S S D i r e c t o r y : : G e t S i z e     ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5ğ"¼5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5Ğõ»5 ø»5à"¼5p¼5àÎ­5 6 6°ö»5 ø»5pø»5Ğù»50¼5ø»5À"¼5 ú»5û»50ı»50ş»50ÿ»5 ¼5 ¼5 ¼50¼5àÎ­5@Ô¢5àş5¤ø5 £ø5à!¼5 å¸5°ä¸5°{ƒ5    €N†5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5°"¼5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5@â»5ğâ»5`ç»5Pç»5 N†5@Ô¢5@Ô¢5àÎ­5àÎ­5@Ô¢5`Ë×5ğ»5ñ»5 ò»5Àó»5ÿ“5@ö5R5àî»5Ğì»5@N†5@aÚ50;ˆ5@ê»5àê»5€ë»5ğë»5àå¸5 6Ğu¾5ĞOš5ĞOš5`ì»5ğí»50Íˆ5 µ 5P€»5Ğ!¼5 å¸5°ä¸5°{ƒ5P²Î5P-„5 ‹Ã5@zƒ5@zƒ5@zƒ5@zƒ5€î5 xƒ5 ~ƒ5 €ƒ5Ğ€ƒ5 ƒ5°xƒ50wƒ5°xƒ50wƒ5 ƒ5@ß¹5Pö5ğpƒ5@ö5@ƒ5`ƒ5àtƒ5pƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5 „5`cÓ5àÎ­5°{ƒ5ğoƒ5°¼5Ğ„5à„5ğ±Î5Àµö5À“µ5àÎ­5 ¨6@÷5ĞÃ5ğM†5`F­5p"¼5P"¼5"¼5p½Í5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 "¼5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5Ğ¼5¼5ğ!¼5à¼50¼5P²Î5P-„5 ‹Ã5@zƒ5@zƒ5@zƒ5@zƒ5€î5 xƒ5 ~ƒ5 €ƒ5Ğ€ƒ5 ƒ5°xƒ50wƒ5°xƒ50wƒ5 ƒ5@ß¹5Pö5ğpƒ5@ö5@ƒ5`ƒ5àtƒ5pƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5 „5`cÓ5àÎ­5°{ƒ5ğoƒ5¼5Ğ„5à„5ğ±Î5Àµö5À“µ5àÎ­5 ¨6@÷5ğŠê5Ğ½Í5ğ“§5P„5„5Àíå5 ¡Ä5p„5„5P+ 5€.¸5p „5  „5 „5€„5À„5 „5 „5@„5 „5p„5Ğ„50„50„5€¼5@Ô¢5°(ç5M„5 ‹ê5@Ô¢5 ¼5 ]6à]6 ^6`^6 ^6P F X m l E n c o d e A n d A d d S t r i n g   e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f x m l c o n v e r t . c p p       P F B u f f e r e d M e m C o n n e c t i o n : : C o n n e c t         e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f b u f f e r e d s t r e a m . c p p       €N†5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5pN†5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5P3¼5PN†5À4¼5 ¨6 5¼5Pö5p5¼5@Ô¢5@ß¹5 4¼5@N†5@aÚ50;ˆ5À5¼507¼5ğ¢¶5ĞáÎ5ĞOš5 N†5Ğu¾5ĞOš5ĞOš5ĞáÎ5u¾5P F C o m p r e s s e d S t r e a m : : I n i t     e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f c o m p r e s s e d s t r e a m . c p p   C o m p r e s s e d   s t r e a m   P F C o m p r e s s e d S t r e a m : : C o p y T o         €N†5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5pN†5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5Ğ>¼50<¼5A¼5P<¼5`A¼5p=¼5`C¼5=¼5°=¼5À@¼5À?¼5@N†5@aÚ50;ˆ5C¼5pF¼5 ÙÃ5@=¼5àG¼5 N†5 <¼5À<¼5 =¼5p<¼5PJ¼5P F C h u n k C u r s o r : : G e t N e x t B l o c k   e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f t c p . c p p     P C X A c c e p t B u f f e r : : A s y n c A c c e p t     l o c a l h o s t   ( l o c a l )   l o c a l       P F I X A C o n n e c t i o n T r a n s p o r t : : S e t P a s s w o r d       P F I X A C o n n e c t i o n T r a n s p o r t : : G e t P a s s w o r d       P²Î5‚¼5P‚¼5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 ÿ¯5Ğwƒ5ğoƒ5€‚¼5 k¼5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5à€¼5Pö5p„¼5P F S O A P M e s s a g e : : B e g i n M e s s a g e   e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f s o a p m s g . c p p     P F H T T P C o n n e c t i o n : : C o n n e c t       e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ u t i l \ p f h t t p . c p p   M S O L A P   9 . 0   C l i e n t       P F H T T P C o n n e c t i o n : : R u n P r o x y A u t o d e t e c t i o n S t e p   P F H T T P C o n n e c t i o n : : C r e a t e S t r e a m     P F H T T P S t r e a m : : W r i t e H t t p D a t a   C o n t e n t - T y p e :        
 S O A P A c t i o n :   " u r n : s c h e m a s - m i c r o s o f t - c o m : x m l - a n a l y s i s : D i s c o v e r "    
 S O A P A c t i o n :   " u r n : s c h e m a s - m i c r o s o f t - c o m : x m l - a n a l y s i s : E x e c u t e "     
X-Transport-Caps-Negotiation-Flags: %d,%d,%d,%d,%d    X - T r a n s p o r t - C a p s - N e g o t i a t i o n - F l a g s     % d , % d , % d , % d , % d     s t r V a l u e     P F H T T P S t r e a m : : R e a d         P F V e c t o r B a s e < s t r u c t   P F H T T P S t r e a m : : s t H T T P B u f f e r > : : I n s e r t   P F V e c t o r B a s e < s t r u c t   P F H T T P S t r e a m : : s t H T T P B u f f e r > : : G r o w       P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ50‡¼5À0¶5`Ë×5P‰¼5ğ‘¼50\©5P’¼5@Ô¢5@Ô¢5PÔ¢5 §ç5p@6    €N†5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5pN†5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5ˆ¼5PN†5À«¼5 ¨6ÿ“5`Ë×5ğ«¼5@Ô¢5ç5@N†5@aÚ50;ˆ5¬¼5à—¼5ğ¢¶5ĞáÎ5ĞOš5 N†5Ğu¾5ĞOš5ĞOš5ĞáÎ5u¾5p a r a m   r e s t     P F V e c t o r B a s e < s t r u c t   P F D B P a r a m I n f o > : : G r o w         *;
6@ÿ5@wƒ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5*;
6ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5Ğ¶¼5*;
6*;
6*;
6*;
6*;
6    *;
6@ÿ5@wƒ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5*;
6ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5Ğ¶¼5*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Ğ¼5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 Ğ¼5Ğwƒ5ğoƒ5 Â¼5àÇ¼5ĞÈ¼5pÈ¼5ğÈ¼5àÎ­5pÄ¼5 É¼5*;
6*;
6*;
6PÌ¼5PÊ¼5ğÊ¼5 Ë¼5*;
6*;
6*;
6    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5ğÏ¼5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5àÏ¼5Ğwƒ5ğoƒ5¼¼5 ¿¼5 ¿¼5P¿¼5 À¼50¿¼5ĞÏ¼5`¾¼5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5ÀÏ¼5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5°Ï¼5Ğwƒ5ğoƒ5ğµ¼50¿¼5`¹¼5ğ¸¼5º¼5À¹¼5ğº¼5`º¼5€»¼5Ğ»¼5 Ï¼5*;
6@ÿ5@wƒ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5*;
6ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5Ğ¶¼5*;
6*;
6*;
6*;
6D B T Y P E _ P R O P V A R I A N T     P F D B H e l p e r O l e d b : : M a p C o l u m n T y p e S i z e     e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f o l e d b h e l p e r . c p p         P F D B H e l p e r O l e d b : : C o n v e r t O l e d b T o V a r i a n t     P F D B H e l p e r O l e d b : : C o n v e r t O l e d b T o V a l u e         P F D B H e l p e r O l e d b : : M a p X s d T y p e T o O l e d b     n o     y e s   i n _ C a n U s e P a r a m s   / S e l e c t / / R e m o t e Q u e r y / P a s s w o r d       / S e l e c t / / R e m o t e Q u e r y / C o n n e c t i o n S t r i n g       / S t a t e m e n t / P a r a m e t e r s / P a r a m e t e r / @ r e f     / S t a t e m e n t / T e x t       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : r e m o t e - c o n n e c t i o n - s t r i n g - t r a n s l a t i o n - b e h a v i o r         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : l i m i t - m a x - c o n n e c t i o n s - c o u n t     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : l i m i t - m a t e r i a l i z e d - v i e w - c o l u m n - c o u n t   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : l i m i t - c o l u m n - i d e n t i f i e r - l e n g t h       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : l i m i t - t a b l e - i d e n t i f i e r - l e n g t h         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : l i m i t - d a t a b a s e - i d e n t i f i e r - l e n g t h   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - m a t e r i a l i z e d - v i e w   m s s q l c r t : r e m o t e - p r o p e r t y     m s s q l c r t : d a t a s o u r c e - p r o p e r t y         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : r e m o t e - c o n n e c t i o n - s t r i n g - m a p p i n g s / m s s q l c r t : r e m o t e - c o n n e c t i o n - s t r i n g - m a p p i n g     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - i s o l a t e d - t r a n s a c t i o n - i n - s n a p s h o t - m o d e       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - f a s t - w r i t e b a c k     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - u n i o n - a l l       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - m a t e r i a l i z e d - v i e w - p r e v a l i d a t i o n   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - u n i o n       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - t o p - c l a u s e     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - r e m o t e - q u e r y         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - c a s t         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - c o l u m n - a l i a s         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - t a b l e - a l i a s   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - s u b s e l e c t       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - i n s e r t     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - u p d a t e     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - m u l t i p l e - d i s t i n c t - c o u n t   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - m i l l i s e c o n d         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - s e c o n d   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - m i n u t e   / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - h o u r       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - d a y o f w e e k     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - w e e k       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - d a y         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - d a y o f y e a r     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - m o n t h     / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - q u a r t e r         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t e p a r t - y e a r       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - d a t a - s a m p l i n g       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - r e c u r s i v e - s e l e c t - s u b q u e r y       / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - r e c u r s i v e - s e l e c t         / x s l : s t y l e s h e e t / m s s q l c r t : c a p a b i l i t i e s / m s s q l c r t : s u p p o r t s - l i n k - c h i l d r e n - t o - p a r e n t   x m l n s : x s l = ' h t t p : / / w w w . w 3 . o r g / 1 9 9 9 / X S L / T r a n s f o r m '   x m l n s : m s s q l c r t = ' u r n : s q l - m i c r o s o f t - c o m : s q l c r t '     V A R T Y P E   D B T Y P E     p r e f i x     x s l   P F P r o v i d e r S e r v e d : : I s F o r P r o v i d e r   e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f c r e . c p p     P F C a r t r i d g e : : I n i t   / x s l : s t y l e s h e e t / m s s q l c r t : p r o v i d e r   c a r t f i l e     P F C a r t r i d g e : : D a t a s o u r c e T o R e m o t e C o n n e c t i o n S t r i n g   E x t e n d e d   P r o p e r t i e s   P F C a r t r i d g e : : D a t a s o u r c e T o R e m o t e D a t a s o u r c e   P F C R E n g i n e : : S e l e c t C a r t r i d g e   s t m t     P F C R E n g i n e : : E x e c u t e   < C o l u m n E x p r e s s i o n s > < C o l u m n > < A s t e r i s k / > < / C o l u m n > < / C o l u m n E x p r e s s i o n s >   < W h e r e > < E q u a l > < O p a q u e E x p r e s s i o n > 0 < / O p a q u e E x p r e s s i o n > < O p a q u e E x p r e s s i o n > 1 < / O p a q u e E x p r e s s i o n > < / E q u a l > < / W h e r e >     < S o u r c e s > < T a b l e >     < / T a b l e > < / S o u r c e s >         P F V e c t o r B a s e < c l a s s   P F P r o v i d e r S e r v e d > : : I n s e r t         P F V e c t o r B a s e < c l a s s   P F R e m o t e C o n n e c t i o n P r o p e r t y P a i r > : : I n s e r t     P F V e c t o r B a s e < c l a s s   P F C a r t r i d g e   * > : : I n s e r t       P F V e c t o r B a s e < c l a s s   P F P r o v i d e r S e r v e d > : : G r o w     P F V e c t o r B a s e < c l a s s   P F R e m o t e C o n n e c t i o n P r o p e r t y P a i r > : : G r o w         P F V e c t o r B a s e < c l a s s   P F C a r t r i d g e   * > : : G r o w   ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5…½5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5Ğ7¾5°mß5àÎ­5°{ƒ5ğoƒ5Ğğ¼5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5€…½5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5àû¯5àÎ­5°{ƒ5ğoƒ5Àò¼5 M™50ï¼5 ÷¼5À÷¼5`…½5`Ÿû5 »ó5î°5pò¼5€ û5°ø¼5 ù¼5@…½5äà5 öì5î°5€ø¼5@ Ö5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5à5¹5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5py½5ğ4¹5À†½5*;
6`…½5`Ÿû5 »ó5î°5 †½5€ û5`†½5*;
6@…½5äà5 öì5î°5 …½5@ Ö5MSMDCreateManagedConnection P F V e c t o r B a s e < c l a s s   P F D B C o n n D i s c o v e r I n f o   * > : : I n s e r t     P F V e c t o r B a s e < c l a s s   P F D B C o n n D i s c o v e r I n f o   * > : : G r o w         P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5àÎ­5Ğwƒ5ğoƒ5p˜½5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5`§½5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5pÂ½5@§½5°{ƒ5ğoƒ5Ğˆ½50§½5€½5€½5à½5@‘½5€‘½5”½5 §½5 …5@5…5 ¤½5`¤½5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5`§½5 ƒ5@ß¹5àtƒ5PÂ½5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5Ğ7¾5°mß5§½5°{ƒ5ğoƒ5à£½5°¸½5ğ¸½5¹½5 ¹½5@Æ½5»½5PÆ½5P»½5»½5 ÿ¯5pÈ½5 Ê½5pË½5`Ì½5Ğ»½5 ½½5€Ö½5°½½5Ô½5àÕµ5 ÖÔ5àÎ­5Å½5 Å½5€Â½5pÂ½5pÁ½5PÁ½5Á½5ğÁ½5@Á½50Á½5Â½5Ù½5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5€´½5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5p´½5Ğwƒ5ğoƒ5ğ§½5 ¿¼5°©½5 ¿¼5p«½5 ¿¼5 ¿¼5 ¿¼5À«½5 ¬½5àÎ­5e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f o l e d b c o n n . c p p     P F D B C o n n e c t i o n O l e d b : : S e t C u r r e n t C a t a l o g     P F D B C o n n e c t i o n O l e d b : : S u p p o r t s S n a p s h o t I s o l a t i o n     ; S Q L Q u e r y M o d e =     P F D B C o n n e c t i o n O l e d b : : O p e n D a t a S o u r c e   *;
6Ğå50uƒ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5*;
6 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5 vƒ5°{ƒ5ğoƒ5Pî™5*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5*;
6 ƒ5@ß¹5àtƒ5PÂ½5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5Ğ7¾5°mß5§½5°{ƒ5ğoƒ5àµ½5°¸½5ğ¸½5¹½5 ¹½5*;
6»½5*;
6P»½5»½5 ÿ¯5*;
6*;
6*;
6*;
6Ğ»½5 ½½5*;
6°½½5*;
6àÕµ5 ÖÔ5àÎ­5P·½50¸½5€Â½5pÂ½5pÁ½5PÁ½5Á½5ğÁ½5@Á½50Á½5Â½5*;
6ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 ğ½5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5Ğ7¾5°mß5 ÿ¯5°{ƒ5ğoƒ5´½5€7¾5 {°5€¾5`¾5ğ¾5 ¾5À¾5‹:s*Î­å ª Dw=±Ì"ÁÑ‰à ÀO×¨)    P F D B R e a d e r S h a p e : : A d d S h a p e C o l u m n   e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f s h a p e r e a d e r . c p p         P F D B R e a d e r S h a p e : : A d d K e y C o l O r d i n a l       P F D B R e a d e r S h a p e : : G e t C o l u m n V a l u e   P F D B R e a d e r S h a p e : : G e t C o l u m n V a r i a n t       P F D B R e a d e r S h a p e : : G e t C o l u m n C h a p t e r   P F D B R e a d e r S h a p e : : C o m p a r e K e y s     P F D B R e a d e r S h a p e : : G e t S h a p e C h a p t e r         P F V e c t o r B a s e < s t r u c t   P F D B B i n d S e t t i n g s > : : I n s e r t       P F V e c t o r B a s e < c l a s s   P F I D B R e a d e r   * > : : G r o w   P F V e c t o r B a s e < s t r u c t   P F D B B i n d S e t t i n g s > : : G r o w   ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5P¾5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢50¾5°{ƒ5ğoƒ5 ò½5àÎ­5û½5@û½5P=•5Ğş½5€¾5`¾5 Ğ5 ¾5@¾5ğü½5PôÎ50¾5Ğ¾5Ğu¾5@Ô¢5`û½5 S¾5€û½5 ¾5ğ¾5°¾5ĞáÎ5 ÷È5Ğu¾5Ğu¾5ğ ¾5€¾5 ÷È5u¾5Ğu¾5u¾5À=•5    P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5 ¾5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 Ğ¼5Ğwƒ5ğoƒ50ğ½5àÇ¼5ĞÈ¼5pÈ¼5ğÈ¼5àÎ­5pÄ¼5 É¼5 9¾5@9¾5°ğ½5T a b l e s     T a b l e C o l u m n s     D B S C H E M A _ V I E W S     V i e w s   D B S C H E M A _ F O R E I G N _ K E Y S   F o r e i g n K e y s   D B S C H E M A _ P R I M A R Y _ K E Y S   s c h e m a _ i d e n t i f i e r       P F V e c t o r B a s e < s t r u c t   t a g V A R I A N T > : : I n s e r t   P F V e c t o r B a s e < s t r u c t   t a g V A R I A N T > : : G r o w       *;
6Ğå50uƒ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5*;
6 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5 vƒ5°{ƒ5ğoƒ5pÆ5*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹58¾5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5Ğ7¾5°mß5°7¾5°{ƒ5ğoƒ5`¾5@¾5€¾5À¾50¾5P¾5 ¿¼5 ¾5@¾50¾5 ¿¼5Ğ%¾5&¾5°+¾5€7¾5P F D B R e a d e r O l e d b : : C r e a t e C o l u m n I n f o       e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f o l e d b r e a d e r . c p p     P F D B R e a d e r O l e d b : : B i n d   < I n s e r t > < T a r g e t >         < A s s i g n > < S Q L C o l u m n > < C o l u m n > < N a m e >   < / N a m e > < / C o l u m n > < / S Q L C o l u m n >     " / >   < / C o l u m n U p d a t e s > < / T a r g e t > < / I n s e r t >     P F D B R e a d e r O l e d b : : G e t D a t a I n t e r n a l     s t a t u s         ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5v¾5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5€v¾5°{ƒ5ğoƒ5P;¾5`v¾50J¾5pJ¾5P=•5@V¾5Y¾50Y¾5€K¾5 K¾5p=•5T¾5ÀJ¾5ğX¾5 K¾5°K¾5ğK¾5 L¾5 S¾5 L¾5@v¾5ğeÀ5v¾5ĞáÎ5@Ô¢5Ğu¾5`D¾5 X¾5PY¾5@Ô¢5u¾5@Z¾5u¾5À=•5@u¾5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢50u¾5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 Ğ¼5Ğwƒ5ğoƒ5€8¾5àÇ¼5ĞÈ¼5pÈ¼5ğÈ¼5àÎ­5pÄ¼5 É¼5 9¾5@9¾5    M S M D C a c h e R o w s e t _ < P I D > _ < T I D > _ < R A N D > s . t m p   M S M D C a c h e R o w s e t _ < P I D > _ < T I D > _ < R A N D > . t m p     P F D B R e a d e r C a c h e G r o u p : : N e x t     e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p f \ d b \ p f o l e d b r e a d e r c a c h e . c p p       P F D B R e a d e r C a c h e G r o u p : : G e t C o l u m n C h a p t e r     P F D B R e a d e r C a c h e G r o u p : : S e t C h a p t e r         P F D B R e a d e r C a c h e G r o u p : : G e t C o l u m n I n f o   P F D B R e a d e r C a c h e G r o u p : : G e t C h a p t e r R e a d e r     P F D B R e a d e r C a c h e G r o u p : : S e t T i m e D i m D e f   P F D B R e a d e r C a c h e G r o u p : : A d d R o w         P F D B R e a d e r O l e d b C a c h e : : G e t C o l u m n C o u n t     P F D B R e a d e r O l e d b C a c h e : : S t a r t       P F D B R e a d e r O l e d b C a c h e : : G e t C o l u m n I n f o   P F D B R e a d e r O l e d b C a c h e : : G e t C h a p t e r R e a d e r     P F D B R e a d e r O l e d b C a c h e : : G e t C o l u m n C h a p t e r     P F D B R e a d e r O l e d b C a c h e : : S e t C h a p t e r         P F D B R e a d e r O l e d b C a c h e : : S e t T i m e D i m D e f   P F D B R e a d e r O l e d b C a c h e : : G e t A f f e c t e d       P F D B R e a d e r O l e d b C a c h e : : N e x t R o w s e t         M S M D C a c h e R o w s e t B a d R o w s _ < P I D > _ < I D > _ < R A N D > . t m p     P F V e c t o r B a s e < b o o l > : : I n s e r t         P F V e c t o r B a s e < c l a s s   P F D B C a c h e G r o u p   * > : : G r o w     ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 ¹¾5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5 ¹¾5°{ƒ5ğoƒ5`‘¾5àÎ­50–¾5°–¾5p–¾5À¡¾5 ¦¾5—¾5ğ—¾5@Ô¢5p=•5@¡¾5ğ–¾5`¥¾50—¾5˜¾5P˜¾5p˜¾5€œ¾50™¾5à¸¾5°˜¾5Ğ˜¾5àœ¾5à ¾5P£¾5ğ˜¾5P¤¾5à¦¾5P¨¾5°¸¾5Ğu¾5u¾5€¸¾5 ’¾5P²Î5P-„5 ‹Ã5@zƒ5@zƒ5@zƒ5@zƒ5€î5 xƒ5 ~ƒ5 €ƒ5Ğ€ƒ5 ƒ5°xƒ50wƒ5°xƒ50wƒ5 ƒ5@ß¹5pw¾5ğpƒ5@ö5@ƒ5`ƒ5àtƒ5pƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5 „5`cÓ5ĞÏ†5°{ƒ5ğoƒ5Px¾5Ğ„5à„5ğ±Î5Àµö5À“µ5€î†5 §ç5@Ï†5P~‡5Ğ†5€Ğ†5`ë†5‡5 ‡5‡5P‡5@‡5 ‡5À…‡5P
‡50‡5‡5 ‡5À ‡5Àí†5À‡5ğ‡5@Ğ†5`Ñ†5°Ö†5P×†5Pİ†5@‡5 ‡5 =ˆ5PC6P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5`cÓ5p¸¾5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5P¸¾5Ğwƒ5ğoƒ5€x¾5àÇ¼5ĞÈ¼5pÈ¼5ğÈ¼5àÎ­5pÄ¼5 É¼5 9¾5@9¾5 y¾5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5À¦ô5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 yƒ5 ¡Ä5@¸¾5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5à\6”50¸¾5Ğwƒ5ğoƒ5 z¾5{¾5    P²Î5P3İ5°>…5@zƒ5@zƒ5@zƒ5@zƒ5€î5 xƒ5 ~ƒ5 €ƒ5Ğ€ƒ5 ƒ5°xƒ50wƒ5°xƒ50wƒ5 ƒ5@ß¹5pw¾5ğpƒ5@ö5@ƒ5`ƒ5àtƒ5pƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5 „5`cÓ5ĞÏ†5°{ƒ5ğoƒ5pµ¾5Ğ„5à„5ğ±Î5Àµö5À“µ5€î†5 §ç5@Ï†5P~‡5Ğ†5€Ğ†5`ë†5‡5 ‡5‡5P‡5@‡5 ‡5À…‡5P
‡50‡5‡5 ‡5À ‡5Àí†5À‡5ğ‡5@Ğ†5`Ñ†5°Ö†5P×†5Pİ†5@‡5 ‡5 =ˆ5PC6ğŠê5¸¾5 ¸¾5@ó†5„5Àíå5ğ„5p„5„5°„5€.¸5p „5  „5 „5€„5À„5 „5 „5@„5 „5p„5Ğ„50„5Pï†5 §ç5@Ô¢5°(ç5€“§5°“§5à‡5P‡5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹50¹¾5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5@¹¾5€¹¾5¹¾5°{ƒ5ğoƒ5À¹¾5pº¾5Ğ‡¾5ğ‡¾5P=•5`ˆ¾5€‰¾5‹¾50‹¾5@Ô¢5p=•5àŒ¾5`‹¾5€‹¾5°‹¾5Ğ‹¾5@Ô¢5€á”5ğ‹¾5ğ‹¾5Œ¾5 Œ¾5 “5 Œ¾5ÀŒ¾5Ğ¾5@¾5 ÿ¯5`¾5ÿ“5u¾5p¾5u¾5À=•5°‡¾5»"µÈó\Î­å ª Dw=6èR™¿¿M…5›gÛÙİşói2ˆ­/F¶õèŠrAŒKxŠİ:¹ØÒ* à)OŞwŠİ:¹ØÒ* à)OŞÕ²Bœ§J“i˜É\ıvŠİ:¹ØÒ* à)OŞyŠİ:¹ØÒ* à)OŞuŠİ:¹ØÒ* à)OŞ•Šİ:¹ØÒ* à)OŞÍ| HĞ‡» ÀOÃ9BÍ| HĞ‡» ÀOÃ9BÍ| HĞ‡» ÀOÃ9BŞ"µÈó\Î­å ª Dw=İ"µÈó\Î­å ª Dw=Ü"µÈó\Î­å ª Dw=Û"µÈó\Î­å ª Dw=Ú"µÈó\Î­å ª Dw=Ù"µÈó\Î­å ª Dw=Ø"µÈó\Î­å ª Dw=,"µÈó\Î­å ª Dw="µÈó\Î­å ª Dw=)"µÈó\Î­å ª Dw="µÈó\Î­å ª Dw=ÿƒ˜ú±ïOª’>Y`³•Æ"µÈó\Î­å ª Dw=º"µÈó\Î­å ª Dw=¾"µÈó\Î­å ª Dw=¼"µÈó\Î­å ª Dw=Í| HĞ‡» ÀOÃ9B                        ĞÌ| HĞ‡» ÀOÃ9Bğ"µÈó\Î­å ª Dw=ñ"µÈó\Î­å ª Dw=ò"µÈó\Î­å ª Dw=ó"µÈó\Î­å ª Dw=ú"µÈó\Î­å ª Dw=-"µÈó\Î­å ª Dw=Ä"µÈó\Î­å ª Dw=Å"µÈó\Î­å ª Dw=À"µÈó\Î­å ª Dw=Á"µÈó\Î­å ª Dw=Â"µÈó\Î­å ª Dw=Ç"µÈó\Î­å ª Dw=Ê"µÈó\Î­å ª Dw=Ô"µÈó\Î­å ª Dw=ü"µÈó\Î­å ª Dw=û!µÈó\Î­å ª Dw=×"µÈó\Î­å ª Dw=Ë"µÈó\Î­å ª Dw=e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p c \ m e t a d a t a \ p c s e r i a l i z e . c p p     C o n f i g u r a t i o n S e t t i n g s \     P C D a t a b a s e : : S e r i a l i z e   P a s s w o r d R e m o v e d   U n c h a n g e d    Internal   P F V e c t o r B a s e < u n s i g n e d   s h o r t > : : S e t S i z e       P F V e c t o r B a s e < u n s i g n e d   s h o r t > : : S h r i n k         P F V e c t o r B a s e < s t r u c t   P C P r o p e r t y U s e r D e f i n e d G r o u p > : : I n s e r t   P F V e c t o r B a s e < s t r u c t   P C P r o p e r t y U s e r D e f i n e d G r o u p > : : G r o w       P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5@»¾5€@™5Ğ@™5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5`Ë×5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ5 ¥¿5ĞáÎ5ğ¢¶5P²Î5@ÿ5ÀåÄ5@zƒ5@zƒ5@zƒ5@zƒ5 xƒ5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5°xƒ50wƒ5°xƒ50wƒ5 âÖ5@Ô¢5Pö5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5@yƒ5€¼Ğ5°wƒ5°wƒ5Pv‹5Pv‹5°wƒ5°wƒ5Àwƒ5°wƒ5°wƒ5Àwƒ5àÎ­5@Ô¢5 yƒ5Ğwƒ5ğoƒ50œ¿5àÎ­5`Æ¿5pÇ¿5ĞÈ¿5 ‹ 6`î°5î°5À¿5@¿5`¿5*;
6À¿5 ‹ 6`î°5î°5à¿5@¿5P C P r o p e r t y : : G e t K e y B i n d i n g s         e : \ s q l 9 _ s p 2 _ t \ s q l \ p i c a s s o \ e n g i n e \ s r c \ p c \ m e t a d a t a \ p c p r o p e r t y . c p p   P C P r o p e r t y : : G e t P r o p e r t y T r a n s l a t i o n s   r e l a t e d p r o p e r t y i d       P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5 ƒ5»5tƒ5=±5Pƒ5ç5€Ò¿5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5àÀ5°{ƒ5ğoƒ5Ò¿5PªÁ5`£Á5€£Á5À£Á5 £Á5ÀÜÆ5 ÿ¯5 ¥Á5°ÄÀ5¦Á5àÎ­5¿5p¸¿5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5pÓ¿5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5€Ó¿5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5ÀÏ¿505Ã5°wƒ5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5`Ë×5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5Ï¿5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5ÀÏ¿505Ã5°wƒ5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5M e a s u r e s L e v e l   d i m e n s i o n N a m e   P F V e c t o r B a s e < c l a s s   P C I C u b e P e r s p O b j e c t   * > : : I n s e r t         P F V e c t o r B a s e < c l a s s   P C M a j o r O b j e c t C o l l e c t i o n B a s e   * > : : I n s e r t       P F V e c t o r B a s e < c l a s s   P C I C u b e P e r s p O b j e c t   * > : : G r o w     P F V e c t o r B a s e < c l a s s   P C M a j o r O b j e c t C o l l e c t i o n B a s e   * > : : G r o w   P²Î5P-„5 ‹Ã5@zƒ5@zƒ5@zƒ5@zƒ5€î5 xƒ5 ~ƒ5 €ƒ5Ğ€ƒ5 ƒ5°xƒ50wƒ5°xƒ50wƒ5 ƒ5@ß¹5Pö5ğpƒ5@ö5@ƒ5`ƒ5àtƒ5pƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5 „5`cÓ5àÎ­5°{ƒ5ğoƒ5`­Ş5Ğ„5à„5ğ±Î5Àµö5À“µ5àÎ­5 ¨6p6À5°(ç5M„5 ‹ê5@Ô¢5eÀ5p(ç5…5à Ä5À÷5 	÷5P E R S P E C T I V E   P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç5@Ä5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5ƒ5°{ƒ5ğoƒ5 |À5øÁ5 ­Á5`­Á5À£Á5ÀÂ5€œÈ5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­50t¿5€¬Á5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5ĞÖÁ5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5ÿ“5pçÁ5 ¿¼5ÀèÁ5 ¿¼5 ÿ¯5ĞÃÉ5PòÁ5pÂ5ĞÂ5ĞÂ5ÉÉ5 ¿¼5àÜœ5PmÂ5ÏÉ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6 ¿¼5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5ÂÉ5`ÂÉ5 ÂÉ5àÂÉ5 ÃÉ5àÎ­5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç5°|À5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5²É5°{ƒ5ğoƒ5À|À5øÁ5 ­Á5`­Á5À£Á5ÀÂ50È5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5àt¿5€¬Á5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5ĞÖÁ5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5ÿ“5pçÁ5 ¿¼5ÀèÁ5²É5 ÿ¯5à²É5PòÁ5pÂ5ĞÂ5ĞÂ5ÉÉ5 ¿¼5àÜœ5PmÂ5ÏÉ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6 ¿¼5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5ÂÉ5`ÂÉ5€³É5@³É5 ÄÉ5àÎ­5p±É5 §ç5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 ~À5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5~À5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5ĞyŞ5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5PÏÂ5ğ×Â5Ä5ĞFÁ5€.Ã5PÄ5 ØÂ5 .Ã5    P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç50lÀ5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5P4À5°{ƒ5ğoƒ5@lÀ5øÁ5 ­Á5`­Á5À£Á5ÀÂ5°ßÆ5@¶Ç5 ¥Á5Ğ¨À5¦Á5àÎ­5 /¿5pmÀ5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5ĞÖÁ5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5ÿ“5pçÁ5 ¿¼5ÀèÁ5 ¿¼5 ÿ¯5ĞíÁ5PòÁ5pÂ5ĞÂ5ĞÂ5 ¿¼5 ¿¼5àÜœ5PmÂ5ĞÂ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6 ¿¼5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5mÀ5 Ç­5À>À5à>À50?À5 ?À5 §ç5p>À5 9À5ğ;À59À5@>À5°0À5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 nÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ50nÀ5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5hÀ5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5PÏÂ5ğ×Â5Ä5ĞFÁ5€.Ã5PÄ5 ØÂ5 .Ã5    P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5 ƒ5»5tƒ5=±5Pƒ5ç5ğÏŞ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5€À5°{ƒ5ğoƒ5¨À5PªÁ5`£Á5€£Á5À£Á5 £Á5P–Ç5 ÿ¯5 ¥Á5 ÓÀ5¦Á5àÎ­5°)¿5ğ
À5àÀ5ĞÓÀ5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5 ˆÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5°ˆÀ5Àµö5 À5°2Ã53Ã5À3Ã504Ã5€À5ğŞ505Ã5pÀ5pÀ5 ÿ¯50¼É5°@	6À@	60‰À5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5 ƒ5»5tƒ5=±5Pƒ5ç50¦À5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5 *À5°{ƒ5ğoƒ5@¦À5PªÁ5`£Á5€£Á5À£Á5 £Á5ÀÜÆ5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5ğ€¿5Ğ(À5pfÀ5`fÀ5 fÀ50î­5PfÀ5@fÀ5pÅÍ5 î­50fÀ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5ğŒÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5 À5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5Ş505Ã5°wƒ5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5 ƒ5»5tƒ5=±5Pƒ5ç50ÍŞ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5 .À5°{ƒ5ğoƒ5P¤À5PªÁ5`£Á5€£Á5À£Á5 £Á5ğšÇ5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5Pƒ¿5-À5à"¼5 /±5pfÀ5`fÀ5 fÀ50î­5 î­5fÀ5Pœ5 fÀ5ğeÀ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5PrÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5`rÀ5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5 Ş505Ã5°wƒ5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5P1Á5P(À5tƒ5=±5Pƒ5ç5pÑŞ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5àÀ5°{ƒ5ğoƒ5ğ¢À5PªÁ5`£Á5€£Á5À£Á5 £Á5 Ç5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5P,¿5 À5 À5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5°–À5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5À–À5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5#Ş505Ã5@$Ş5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5 ƒ5»5tƒ5=±5Pƒ5ç5àÕŞ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5°À5°{ƒ5ğoƒ5¢À5PªÁ5`£Á5€£Á5À£Á5 £Á5P Ç5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5`-¿5`À5àÀ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5€’À5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5’À5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã54Ş505Ã5°#À5° À5 ÿ¯50¼É5°@	6À@	6°ñÉ5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ5àpƒ5à~ƒ5°wƒ5P1Á5P(À5tƒ5=±5Pƒ5ç5@ÏŞ5ğpƒ5@ö5zƒ5Pv‹5zƒ5Pv‹5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5p˜Ÿ5€¹¾5àÀ5°{ƒ5ğoƒ5¡À5PªÁ5`£Á5€£Á5À£Á5 £Á5Ğ¯Ç5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5p»¾5 %À5P%À5°&À5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5àšÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5ğšÀ5Àµö5°1Ã5°2Ã53Ã5À3Ã504Ã5p:Ã5PNŞ505Ã5 OŞ5àÎ­5àÎ­50¼É5°@	6À@	6°ñÉ5P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç5°‚À5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5 Á5°{ƒ5ğoƒ5À‚À5øÁ5 ­Á5`­Á5À£Á5ÀÂ50¸Ç5p¶Ç5 ¥Á5°ÕÀ5¦Á5àÎ­5@<¿5€¬Á5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5 Á5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5Á5pçÁ5 ¿¼5ÀèÁ5 ¿¼5 ÿ¯5ĞíÁ5PòÁ5pÂ5ĞÂ5ĞÂ5€Á5 ¿¼5àÜœ5PmÂ5ĞÂ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6€Á5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5 Á5àÕÀ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5p„À5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5€„À5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5°à5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5PÏÂ5ğ×Â5Ä5ĞFÁ5€.Ã5PÄ5 ØÂ5 .Ã5    P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç5à¹ç5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5ĞáÉ5°{ƒ5ğoƒ5pvÀ5øÁ5 ­Á5`­Á5À£Á5ÀÂ5`œÈ5 ÿ¯5 ¥Á5àêÀ5¦Á5àÎ­5`û¾5€¬Á5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5ĞÖÁ5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5ÿ“5pçÁ5 ¿¼5ÀèÁ5 ¿¼5 ÿ¯5ĞíÁ5PòÁ5pÂ5ĞÂ5ĞÂ5 ¿¼5 ¿¼5àÜœ5PmÂ5ĞÂ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6 ¿¼5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5páÉ5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5wÀ5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5 wÀ5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5 µç5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5PÏÂ5ğ×Â5Ä5ĞFÁ5€.Ã5PÄ5 ØÂ5 .Ã5@âÉ5ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5`Ë×5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5°gÀ5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5 iú5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5    P²Î5P-„5 ‹Ã5€|ƒ5 }ƒ5€}ƒ5 ~ƒ5ğ¹5 xƒ5 ~ƒ50Üœ5à¬Á5`Üœ5 ƒ5»5tƒ5=±5Pƒ5ç5`Ë×5ğpƒ5@ö5zƒ5PÁ½5zƒ5Üœ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5 ¥ª5ƒ5°{ƒ5ğoƒ5°kÀ5øÁ5 ­Á5`­Á5À£Á5ÀÂ5°ßÆ5 ÿ¯5 ¥Á5Ğ¨À5¦Á5àÎ­5à»¾5€¬Á5 ¬Á50Á½5À¬Á5ĞºÁ5 ÉÁ5°*Â5àÎ­5 ÍÁ5PÔÁ5ĞÖÁ5ÚÁ5ÚÁ5ÀÚÁ5ÚÁ5@ÛÁ5 ßÁ5`âÁ5ğæÁ5 ¿¼50çÁ5ÿ“5pçÁ5 ¿¼5ÀèÁ5 ¿¼5 ÿ¯5ĞíÁ5PòÁ5pÂ5ĞÂ5ĞÂ5 ¿¼5 ¿¼5àÜœ5PmÂ5ĞÂ5ÀÂ5PÂ5Â5`Â5@Ô¢5 ¨6 ¿¼5*Â5)Â5€)Â5 İœ5p÷Á5Â5øÁ5`øÁ5ĞùÁ5 Â5*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6*;
6ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ5sƒ5Àsƒ5ğsƒ5tƒ5=±5`tƒ5°tƒ5Àtƒ5 }¹5`Ë×5 ƒ5@ß¹5àtƒ5pƒ5 uƒ5 uƒ5p{ƒ5 ¡Ä5 {ƒ5pƒ5°uƒ5€ƒ5Àuƒ5ƒ5°ƒ5àuƒ5 vƒ5@{ƒ5àÎ­5@Ô¢5àÎ­5°{ƒ5ğoƒ5@sÀ5 JÃ5€JÃ5°OÃ5 MÃ5ğ×Â5àRÃ5PPÃ5ĞFÁ5€.Ã5ÀfÃ5`gÃ5ÀnÃ5°oÃ5psÀ5ĞKÃ5€SÃ50dÃ5pbÃ5 YÃ5PÏÂ5ğ×Â5Ä5ĞFÁ5€.Ã5PÄ5 ØÂ5 .Ã5    ğr	6Ğå5€»Æ5€}ƒ5Ğqƒ5Prƒ5Ğrƒ5psƒ5€î5 ~ƒ