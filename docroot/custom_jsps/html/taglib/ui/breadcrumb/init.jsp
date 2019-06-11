<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/taglib/init.jsp" %>

<%
String breadcrumbString = GetterUtil.getString((String)request.getAttribute("liferay-ui:breadcrumb:breadcrumbString"));

/* Get URL Request  */
themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
String urlCurrent = themeDisplay.getURLCurrent();
String homeUrl = themeDisplay.getURLHome();
urlCurrent = java.net.URLDecoder.decode(urlCurrent, "UTF-8");
homeUrl = homeUrl.substring(0, homeUrl.indexOf("/", homeUrl.indexOf("://") + 3));

System.out.println("Url: " + urlCurrent);

StringBuilder categoryPath = new StringBuilder("");
String path = "";
String urlArticle = "";
String articleName = "";
String categoryIdSelected = "";
Long parrentId = Long.parseLong("-1");
boolean isContent = false;

if (urlCurrent.indexOf("?redirect=") > -1)
	isContent = true;

/* For list article */
if(!isContent) {
	System.out.println("This is a list article context");
} else { /* For a content article */
	System.out.println("This is a content article context");
	String reverse = new StringBuffer(urlCurrent).reverse().toString();
	System.out.println("reverse: " + reverse);
	int start = reverse.indexOf("tcerider?");
	int end = reverse.indexOf("/", start);
	
	if(start > -1 && end > -1 && end > (start + "tcerider?".length())) {
		urlArticle = new StringBuffer(reverse.substring((start + "tcerider?".length()), end)).reverse().toString();
		System.out.println("urlArticle: " + urlArticle);
		JournalArticle journalArticleByTitleUrl = JournalArticleLocalServiceUtil.getArticleByUrlTitle(themeDisplay.getScopeGroupId(), urlArticle);
		Long articleId = journalArticleByTitleUrl.getPrimaryKey();
		JournalArticle journalArticleById = JournalArticleLocalServiceUtil.getArticle(articleId);
		String languageId = LanguageUtil.getLanguageId(request);
		articleName = journalArticleById.getTitle(languageId);
		
		System.out.println("articleName: " + articleName);
	}
}

//String categoryIdSelected = request.getParameter("p_r_p_564233524_categoryId");
int startIndex = urlCurrent.indexOf("categoryId=");
int endIndex = urlCurrent.indexOf("&", startIndex);
System.out.println("indexOf start: " + startIndex);
System.out.println("indexOf end:" + endIndex);

if(startIndex > -1 && endIndex > -1 && endIndex > (startIndex + "categoryId=".length()))
	categoryIdSelected = urlCurrent.substring((startIndex + "categoryId=".length()), endIndex);
else
	if(startIndex > -1 && urlCurrent.length() > (startIndex + "categoryId=".length()))
		categoryIdSelected = urlCurrent.substring((startIndex + "categoryId=".length()), urlCurrent.length());

boolean isCategoryIdNumber = true;

try {
	Long.valueOf(categoryIdSelected);
} catch (Exception e) {
	isCategoryIdNumber = !isCategoryIdNumber;
}

/* Is category id is number  */
if(isCategoryIdNumber) {
	System.out.println("CategoryId Selected: " + categoryIdSelected);
	parrentId = Long.parseLong(categoryIdSelected.trim());

	if (categoryIdSelected != null && categoryIdSelected.length() > 0) {
		/* Get category and subcategory  */
		while(parrentId != Long.parseLong("0")) {
			List<AssetCategory> category = null;
			try {
				category = AssetCategoryLocalServiceUtil.getCategories();
				categoryIdSelected = String.valueOf(parrentId);
				
				for (AssetCategory item : category) {
					if (String.valueOf(item.getCategoryId()).equals(categoryIdSelected)) {
						categoryPath.insert(0, "<a href='" + homeUrl + "/web/guest/bai-viet?p_p_id=122_INSTANCE_1nwMhNWDv4fn&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&p_r_p_564233524_resetCur=true&p_r_p_564233524_categoryId=" + item.getCategoryId() + "'>" + item.getName() + "</a> / ");
						parrentId = item.getParentCategoryId();
						//System.out.println("Current category: " + categoryPath);
						//System.out.println("Parrent category: " + parrentId);
						break;
					}
				}
			} catch (SystemException e) {
				e.printStackTrace();
				break;
			}
		}
		
		path = categoryPath.toString();
		path = path.trim();
		path = path.substring(0, path.lastIndexOf("/"));
	}	
}

if(!articleName.trim().equals(""))
	path += " / " + articleName;
	

%>