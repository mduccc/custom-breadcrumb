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

<%@page import="java.nio.file.Path"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@ include file="/html/taglib/ui/breadcrumb/init.jsp" %>

<!-- This is a default -->
<%-- <c:if test="<%= Validator.isNotNull(breadcrumbString) %>">
	<ul aria-label="<%= LanguageUtil.get(pageContext, "breadcrumb") %>" class="breadcrumb">
		<%= breadcrumbString %>
	</ul>
</c:if> --%>

<!-- This is a cusom -->
<% System.out.println("Path: " + path); %>
<c:if test="<%= Validator.isNotNull(path) %>">
<ul aria-label="<%= LanguageUtil.get(pageContext, "breadcrumb") %>" class="breadcrumb">
	<%= path %>
</ul>
</c:if>
