package ca.logaritm.dezel.text.font;

import android.content.Context;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class FontFile {

	private static ArrayList<String> mFontWeights = new ArrayList<>();

	static {
		mFontWeights.add("Extralight");
		mFontWeights.add("Ultralight");
		mFontWeights.add("Thin");
		mFontWeights.add("Light");
		mFontWeights.add("Book");
		mFontWeights.add("Demi");
		mFontWeights.add("Natural");
		mFontWeights.add("Regular");
		mFontWeights.add("Medium");
		mFontWeights.add("Semibold");
		mFontWeights.add("Demibold");
		mFontWeights.add("Bold");
		mFontWeights.add("Extrabold");
		mFontWeights.add("Heavy");
		mFontWeights.add("Black");
		mFontWeights.add("Extrablack");
		mFontWeights.add("Ultrablack");
	}

	private static ArrayList<String> mFontStyles = new ArrayList<>();

	static {
		mFontStyles.add("Normal");
		mFontStyles.add("Italic");
	}

	private Context mContext;

	private String mFile;
	private String mPath;

	private String mFontName;
	private String mFontFamily = "Roboto";
	private String mFontWeight = "Regular";
	private String mFontStyle = "Normal";
	private String mFontFamilyNormalized = "sans-serif";
	private String mFontWeightNormalized = "400";
	private String mFontStyleNormalized = "normal";

	private FontReader mStream;

	private HashMap<String, TableRecord> mTables = new HashMap<>();

	public FontFile(Context context, String path, String file) {

		mContext = context;
		mPath = path;
		mFile = file;

		try {

			mStream = new FontReader(context.getAssets().open(path + "/" + file));
			mStream.skipInt32();

			int tables = mStream.readUInt16();

			mStream.skipInt16();
			mStream.skipInt16();
			mStream.skipInt16();

			for (int i = 0; i < tables; i++) {

				String tag = mStream.readString(4);

				TableRecord table = new TableRecord();
				table.checksum = mStream.readUInt32();
				table.offset = mStream.readUInt32();
				table.length = mStream.readUInt32();

				mTables.put(tag, table);
			}

			TableRecord name = mTables.get("name");

			if (name == null) {
				return;
			}

			mStream.seek(name.offset);

			mStream.skipInt16();
			int length = mStream.readUInt16();
			int offset = mStream.readUInt16();

			ArrayList<NameRecord> records = new ArrayList<>();

			for (int i = 0; i < length; i++) {

				NameRecord record = new NameRecord();
				record.platformID = mStream.readUInt16();
				record.encodingID = mStream.readUInt16();
				record.languageID = mStream.readUInt16();
				record.nameID = mStream.readUInt16();
				record.stringLength = mStream.readUInt16();
				record.stringOffset = mStream.readUInt16();

				if (record.nameID > 4) {
					break;
				}

				records.add(record);
			}

			for (NameRecord record : records) {

				mStream.seek(name.offset + offset + record.stringOffset);

				String value = mStream.readString(record.stringLength);

				if (record.nameID == 1) {
					parseFontFamily(value);
					continue;
				}

				if (record.nameID == 2) {
					parseFontSubFamily(value);
					continue;
				}

				if (record.nameID == 4) {
					mFontName = value;
					continue;
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void parseFontFamily(String value) {

		for (String weight : mFontWeights) {
			int index = value.indexOf(weight);
			if (index > -1) {
				mFontWeight = weight;
				mFontFamily = value.replace(weight, "").trim();
				mFontFamilyNormalized = mFontFamily.toLowerCase();
				mFontWeightNormalized = mFontWeight.toLowerCase();
				break;
			}
		}

		switch (mFontWeightNormalized) {
			case "extralight":
			case "ultralight":
				mFontWeightNormalized = "100";
				break;
			case "light":
			case "thin":
				mFontWeightNormalized = "200";
				break;
			case "book":
			case "demi":
				mFontWeightNormalized = "300";
				break;
			case "normal":
			case "regular":
				mFontWeightNormalized = "400";
				break;
			case "medium":
				mFontWeightNormalized = "500";
				break;
			case "semibold":
			case "demibold":
				mFontWeightNormalized = "600";
				break;
			case "bold":
				mFontWeightNormalized = "700";
				break;
			case "black":
			case "heavy":
			case "extrabold":
				mFontWeightNormalized = "800";
				break;
			case "extrablack":
			case "ultrablack":
				mFontWeightNormalized = "900";
				break;
		}
	}

	private void parseFontSubFamily(String value) {

		for (String style : mFontStyles) {
			int index = value.indexOf(style);
			if (index > -1) {
				mFontStyle = style;
				mFontStyleNormalized = mFontStyle.toLowerCase();
				break;
			}
		}

		mFontStyle = "Normal";
		mFontStyleNormalized = "normal";
	}

	public Context getContext() {
		return mContext;
	}

	public String getFile() {
		return mFile;
	}

	public String getPath() {
		return mPath;
	}

	public String getFontFamily() {
		return mFontFamily;
	}

	public String getFontWeight() {
		return mFontWeight;
	}

	public String getFontStyle() {
		return mFontStyle;
	}

	public String getFontName() {
		return mFontName;
	}

	public String getFontFamilyNormalized() {
		return mFontFamilyNormalized;
	}

	public String getFontWeightNormalized() {
		return mFontWeightNormalized;
	}

	public String getFontStyleNormalized() {
		return mFontStyleNormalized;
	}

	private static class TableRecord {
		public int offset;
		public int length;
		public int checksum;
	}

	private static class NameRecord {
		public int nameID;
		public int platformID;
		public int encodingID;
		public int languageID;
		public int stringLength;
		public int stringOffset;
	}
}
