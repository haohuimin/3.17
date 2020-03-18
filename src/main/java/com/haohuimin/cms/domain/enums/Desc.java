package com.haohuimin.cms.domain.enums;

public enum Desc {

		HTML("文字形式发布的文章"),
		IMAGE("表示该文章不是文本内容而是图片");
		
		private String displayName;

		private Desc(String displayName) {
			this.displayName = displayName;
		}

		public String getDisplayName() {
			return displayName;
		}

		public String getName() {
			return this.name();
		}
		
		public int getOrdinal() {
			return this.ordinal();
		}

}
