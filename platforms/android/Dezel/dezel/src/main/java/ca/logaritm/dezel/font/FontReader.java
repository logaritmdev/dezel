package ca.logaritm.dezel.font;

import android.support.annotation.NonNull;

import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;

public class FontReader extends FilterInputStream {

	private int mPosition;

	public int getPosition() {
		return mPosition;
	}

	public FontReader(InputStream in) {
		super(in);
	}

	public void seek(int position) throws IOException {
		skip(position - mPosition);
	}

	public void skipInt16() throws IOException {
		skip(2);
	}

	public void skipInt32() throws IOException {
		skip(4);
	}

	public int readUInt16() throws IOException {
		return (read() << 8 | read()) >>> 0;
	}

	public int readUInt32() throws IOException {
		return (read() << 24 | read() << 16 | read() << 8 | read()) >>> 0;
	}

	public String readString(int length) throws IOException {

		char[] chars = new char[length];

		for (int i = 0; i < length; i++) {
			chars[i] = (char) read();
		}

		return new String(chars);
	}

	@Override public long skip(long n) throws IOException {
		long skipped = super.skip(n);
		mPosition += skipped;
		return skipped;
	}

	@Override public int read() throws IOException {

		int b = super.read();
		if (b >= 0) {
			mPosition++;
		}

		return b;
	}

	@Override public int read(@NonNull byte[] b) throws IOException {
		return read(b, 0, b.length);
	}

	@Override public int read(@NonNull byte[] b, int off, int len) throws IOException {

		int bytes = super.read(b, off, len);
		if (bytes >= 0) {
			mPosition += bytes;
		}

		return bytes;
	}
}
