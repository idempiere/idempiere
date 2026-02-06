
/******************************************************************************
 * Copyright (C) 2014 Low Heng Sin                                            *
 * Copyright (C) 2014 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.apps;

import static org.adempiere.base.markdown.IMarkdownRenderer.MARKDOWN_CLOSING_TAG;
import static org.adempiere.base.markdown.IMarkdownRenderer.MARKDOWN_OPENING_TAG;

import java.text.Format;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.search.ISearchProvider;
import org.adempiere.base.search.SearchResult;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.I_AD_SearchDefinition;
import org.compiere.model.MColumn;
import org.compiere.model.MMessage;
import org.compiere.model.MQuery;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.compiere.util.Util;

import org.zkoss.zhtml.Style;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 */
public class DocumentSearchController implements EventListener<Event> {

	private static final String WINDOW_NAME_CONTEXT_VARIABLE = "WindowName";
	private static final String ROW_NO_CONTEXT_VARIABLE = "Row";

	private static final String HEADER_OPENING_TAG = "<#header>";
	private static final String HEADER_CLOSING_TAG = "</#header>";
	private static final String FOOTER_OPENING_TAG = "<#footer>";
	private static final String FOOTER_CLOSING_TAG = "</#footer>";

	/** Style for transaction code guide or execution error */
	private static final String MESSAGE_LABEL_STYLE = "color: rgba(0,0,0,0.34)";
	/**
	 * {@link A} component attribute to hold reference to corresponding
	 * {@link #SEARCH_RESULT}
	 **/
	private static final String SEARCH_RESULT = "search.result";
	/** onSearchDocuments event **/
	private static final String ON_SEARCH_DOCUMENTS_EVENT = "onSearchDocuments";
	/**
	 * layout to show links ({@link A}) for each {@link #SEARCH_RESULT} in
	 * {@link #list}
	 **/
	private Vlayout layout;
	/** results from execution of search **/
	private ArrayList<SearchResult> list;
	/** Current selected index of {@link #list} **/
	private int selected = -1;
	/** True when showing transaction code available */
	private boolean showingGuide = false;
	
	/**
	 * default constructor
	 */
	public DocumentSearchController() {
	}

	/**
	 * Create {@link #layout} for search result
	 * 
	 * @param parent
	 */
	public void create(Component parent) {
		layout = new Vlayout();
		layout.setStyle("padding: 3px; overflow:auto;");
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setVflex(layout, "true");

		parent.appendChild(layout);

		layout.addEventListener(ON_SEARCH_DOCUMENTS_EVENT, this);
	}

	/**
	 * Echo {@link #ON_SEARCH_DOCUMENTS_EVENT} with value as event data.
	 * 
	 * @param value
	 */
	public void search(String value) {
		if (Util.isEmpty(value) || (value.startsWith("/") && value.indexOf(" ") < 0)) {
			if (!showingGuide)
				layout.getChildren().clear();
		} else {
			layout.getChildren().clear();
		}
		Events.echoEvent(ON_SEARCH_DOCUMENTS_EVENT, layout, value);
	}

	/**
	 * Handle {@link #ON_SEARCH_DOCUMENTS_EVENT} event.<br/>
	 * Delegate execution of search to {@link #doSearch(String)}.
	 * 
	 * @param searchString
	 */
	private void onSearchDocuments(String searchString) {
		list = new ArrayList<SearchResult>();
		if (Util.isEmpty(searchString) || (searchString.startsWith("/") && searchString.indexOf(" ") < 0)) {
			// No search string, show available transaction code
			if (!showingGuide) {
				Query query = new Query(Env.getCtx(), I_AD_SearchDefinition.Table_Name, "TransactionCode IS NOT NULL",
						null);
				List<MSearchDefinition> definitions = query.setOnlyActiveRecords(true).setOrderBy("TransactionCode")
						.list();
				for (MSearchDefinition definition : definitions) {
					Label label = new Label("/" + definition.getTransactionCode() + " " + definition.getName());
					label.setStyle(MESSAGE_LABEL_STYLE);
					layout.appendChild(label);
				}
				showingGuide = true;
			}
			return;
		}
		showingGuide = false;

		// Search and show results
		List<SearchResult> list = doSearch(searchString);

		// display search result
		if (list.size() == 1 && list.get(0).getRecordId() == -1) {
			// DB error or query timeout
			Label label = new Label(list.get(0).getLabel());
			label.setStyle(MESSAGE_LABEL_STYLE);
			layout.appendChild(label);
		} else if (list.size() > 0) {
			// sort by window name and ad_message_id
			Collections.sort(list, new Comparator<SearchResult>() {
				@Override
				public int compare(SearchResult o1, SearchResult o2) {
					int r = o1.getWindowName().compareTo(o2.getWindowName());
					if (r == 0) {
						// if using relevance score, sort by relevance score descending
						if (o1.getRelevanceScore() != 0.0 || o2.getRelevanceScore() != 0.0) 
							r = Double.compare(o2.getRelevanceScore(), o1.getRelevanceScore());
						else if (o1.getAD_Message_ID() > 0 && o2.getAD_Message_ID() > 0)
							r = o1.getAD_Message_ID() - o2.getAD_Message_ID();
						else
							r = o1.getLabel().compareTo(o2.getLabel());
					}
					return r;
				}
			});

			String matchString = searchString.toLowerCase();
			if (searchString != null && searchString.startsWith("/") && searchString.indexOf(" ") > 1) {
				// "/TransactionCode Search Text"
				matchString = searchString.substring(searchString.indexOf(" ") + 1).toLowerCase();
			}

			String windowName = null;
			int currentMessageId = 0;
			int currentMessageCount = 0;
			StringBuilder bufferedContent = new StringBuilder();
			Map<Integer, Boolean> markDownMessageMap = new HashMap<Integer, Boolean>();
			Map<Integer, String> messageHeaderMap = new HashMap<Integer, String>();
			Map<Integer, String> messageFooterMap = new HashMap<Integer, String>();
			Map<Integer, String> messageContentMap = new HashMap<Integer, String>();
			int currentStyleId = 0;
			SearchResult previousResult = null;
			for (SearchResult result : list) {
				if (result.getAD_Message_ID() > 0) {
					if (result.getAD_Message_ID() != currentMessageId) {
						if (currentMessageId > 0 && bufferedContent.length() > 0) {
							renderBufferedContent(bufferedContent, currentStyleId,
									markDownMessageMap.get(currentMessageId), messageFooterMap.get(currentMessageId),
									previousResult, matchString);
							bufferedContent = new StringBuilder();
						}
						loadMessage(result.getAD_Message_ID(), messageHeaderMap, messageFooterMap, messageContentMap,
								markDownMessageMap);
						currentMessageCount = 1;
						currentMessageId = result.getAD_Message_ID();
						currentStyleId = result.getAD_Style_ID();
					} else {
						currentMessageCount++;
					}
					result.setRow(currentMessageCount);
					windowName = renderFormattedResult(matchString, windowName, result, currentMessageCount,
							bufferedContent, markDownMessageMap, messageHeaderMap, messageContentMap, messageFooterMap);
				} else {
					windowName = renderSearchResult(matchString, windowName, result);
					currentMessageId = 0;
					currentMessageCount = 0;
				}
				previousResult = result;
			}

			if (bufferedContent.length() > 0) {
				renderBufferedContent(bufferedContent, currentStyleId, markDownMessageMap.get(currentMessageId),
						messageFooterMap.get(currentMessageId), previousResult, matchString);
			}

			layout.invalidate();
		}
	}

	/**
	 * Load AD_Message and break into header, footer and content part. <br/>
	 * Identify whether loaded message is markdown text.
	 * 
	 * @param AD_Message_ID
	 * @param messageHeaderMap
	 * @param messageFooterMap
	 * @param messageContentMap
	 * @param markDownMessageMap
	 */
	private void loadMessage(int AD_Message_ID, Map<Integer, String> messageHeaderMap,
			Map<Integer, String> messageFooterMap, Map<Integer, String> messageContentMap,
			Map<Integer, Boolean> markDownMessageMap) {
		MMessage msg = MMessage.get(Env.getCtx(), AD_Message_ID);
		String msgText = Msg.getMsg(Env.getAD_Language(Env.getCtx()), msg.getValue());
		String trimText = msgText.trim();
		boolean isMarkDown = trimText.startsWith(MARKDOWN_OPENING_TAG) && trimText.endsWith(MARKDOWN_CLOSING_TAG);
		markDownMessageMap.put(AD_Message_ID, isMarkDown);
		if (isMarkDown)
			msgText = msgText.replace(MARKDOWN_OPENING_TAG, "").replace(MARKDOWN_CLOSING_TAG, "").trim();

		if (msgText.indexOf(HEADER_OPENING_TAG) >= 0 && msgText.indexOf(HEADER_CLOSING_TAG) > 0) {
			int start = msgText.indexOf(HEADER_OPENING_TAG);
			int end = msgText.indexOf(HEADER_CLOSING_TAG, start);
			String header = msgText.substring(start + HEADER_OPENING_TAG.length(), end).trim();
			msgText = msgText.substring(end + HEADER_CLOSING_TAG.length()).trim();
			messageHeaderMap.put(AD_Message_ID, header);
		}

		if (msgText.indexOf(FOOTER_OPENING_TAG) >= 0 && msgText.indexOf(FOOTER_CLOSING_TAG) > 0) {
			int start = msgText.indexOf(FOOTER_OPENING_TAG);
			int end = msgText.indexOf(FOOTER_CLOSING_TAG, start);
			String footer = msgText.substring(start + FOOTER_OPENING_TAG.length(), end).trim();
			msgText = msgText.substring(0, start);
			messageFooterMap.put(AD_Message_ID, footer);
		}
		messageContentMap.put(AD_Message_ID, msgText.trim());
	}

	/**
	 * Render search result with formatting text from AD_Message
	 * 
	 * @param matchString
	 * @param windowName
	 * @param result
	 * @param currentMessageCount
	 * @param bufferedContent
	 * @param markDownMessageMap
	 * @param messageHeaderMap
	 * @param messageContentMap
	 * @param messageFooterMap
	 * @return rendered text
	 */
	private String renderFormattedResult(String matchString, String windowName, SearchResult result,
			int currentMessageCount,
			StringBuilder bufferedContent, Map<Integer, Boolean> markDownMessageMap,
			Map<Integer, String> messageHeaderMap, Map<Integer, String> messageContentMap,
			Map<Integer, String> messageFooterMap) {
		StringBuilder msgText = new StringBuilder();
		// add header if row=1
		if (currentMessageCount == 1) {
			String header = messageHeaderMap.get(result.getAD_Message_ID());
			if (!Util.isEmpty(header, true)) {
				msgText.append(header).append("\n");
			}
		}
		msgText.append(messageContentMap.get(result.getAD_Message_ID()));

		if (windowName == null || !windowName.equals(result.getWindowName())) {
			windowName = result.getWindowName();
			if (!msgText.toString().contains(Evaluator.VARIABLE_START_END_MARKER + WINDOW_NAME_CONTEXT_VARIABLE
					+ Evaluator.VARIABLE_START_END_MARKER)) {
				Label label = new Label(windowName);
				LayoutUtils.addSclass("window-name", label);
				layout.appendChild(label);
			}
		}

		boolean isMarkdownMessage = markDownMessageMap.get(result.getAD_Message_ID());
		String formattedContent = parseMessageFormat(matchString, result, msgText.toString(), isMarkdownMessage);

		if (!Util.isEmpty(formattedContent, true)) {
			// buffer if it is markdown or there are header/footer
			boolean buffer = isMarkdownMessage || messageHeaderMap.containsKey(result.getAD_Message_ID())
					|| messageFooterMap.containsKey(result.getAD_Message_ID());
			if (!buffer) {
				addHtmlResult(result, formattedContent);
			} else {
				if (bufferedContent.length() > 0)
					bufferedContent.append("\n");
				bufferedContent.append(formattedContent);
			}
		}

		return windowName;
	}

	/**
	 * Parse MessageFormat with arguments from search result
	 * 
	 * @param matchString
	 * @param result
	 * @param msgText           message format text
	 * @param isMarkdownMessage
	 * @return parsed text
	 */
	private String parseMessageFormat(String matchString, SearchResult result, String msgText,
			boolean isMarkdownMessage) {
		String formattedContent = null;

		// parse context variable
		int firstAt = msgText.indexOf(Evaluator.VARIABLE_START_END_MARKER);
		int secondAt = firstAt >= 0 && firstAt < msgText.length()
				? msgText.indexOf(Evaluator.VARIABLE_START_END_MARKER, firstAt + 1)
				: -1;
		if (firstAt >= 0 && secondAt > firstAt) {
			DefaultEvaluatee evaluatee = new DefaultEvaluatee(new SearchResultDataProvider(result));
			if (!Util.isEmpty(matchString, true)) {
				for (String key : result.getValueMap().keySet()) {
					Object value = result.getValueMap().get(key);
					if (value == null) {
						result.getValueMap().put(key, "");
					} else if (value instanceof String input) {
						StringBuilder sb = new StringBuilder();
						if (addHighlightSpan(matchString, input, sb))
							result.getValueMap().put(key, sb.toString());
					}
				}
			}
			msgText = Env.parseVariable(msgText, evaluatee, false, false);
		}

		// process message format
		MessageFormat mf = null;
		try {
			mf = new MessageFormat(msgText, Env.getLanguage(Env.getCtx()).getLocale());
		} catch (Exception e) {
			String msgValue = MMessage.get(Env.getCtx(), result.getAD_Message_ID()).getValue();
			CLogger.getCLogger(getClass()).log(Level.SEVERE,
					msgValue + "=" + Msg.getMsg(Env.getAD_Language(Env.getCtx()), msgValue), e);
		}
		if (mf != null) {
			Format[] fmts = mf.getFormatsByArgumentIndex();
			Object[] arguments = new Object[fmts.length];
			if (result.getValues() != null && result.getValues().length >= arguments.length) {
				for (int i = 0; i < arguments.length; i++)
					arguments[i] = result.getValues()[i] != null ? result.getValues()[i] : "";

			}

			// add highlight
			if (!Util.isEmpty(matchString, true)) {
				for (int i = 0; i < arguments.length; i++) {
					if (arguments[i] instanceof String value) {
						StringBuilder sb = new StringBuilder();
						if (addHighlightSpan(matchString, value, sb))
							arguments[i] = sb.toString();
					}
				}
			}

			formattedContent = mf.format(arguments);
			// markdown inside html message
			if (!isMarkdownMessage && formattedContent.indexOf(MARKDOWN_OPENING_TAG) >= 0
					&& formattedContent.indexOf(MARKDOWN_CLOSING_TAG) > 0) {
				formattedContent = parseMarkdownInHtmlBlock(formattedContent);
			}
		}
		return formattedContent;
	}

	/**
	 * Add highlight span for matchString
	 * 
	 * @param matchString
	 * @param inputString input value
	 * @param sb          output buffer
	 * @return true if added highlight span
	 */
	private boolean addHighlightSpan(String matchString, String inputString, StringBuilder sb) {
		int match = inputString.toLowerCase().indexOf(matchString);
		boolean hasMatch = false;
		while (match >= 0) {
			hasMatch = true;
			if (match > 0) {
				sb.append(inputString.substring(0, match));
				sb.append("<span class='highlight'>");
				sb.append(inputString.substring(match, match + matchString.length()));
				sb.append("</span>");
				inputString = inputString.substring(match + matchString.length());
			} else {
				sb.append("<span class='highlight'>");
				sb.append(inputString.substring(0, matchString.length()));
				sb.append("</span>");
				inputString = inputString.substring(matchString.length());
			}
			match = inputString.toLowerCase().indexOf(matchString);
		}
		if (inputString.length() > 0)
			sb.append(inputString);
		return hasMatch;
	}

	private static class SearchResultDataProvider implements DefaultEvaluatee.DataProvider {

		private SearchResult searchResult;

		private SearchResultDataProvider(SearchResult searchResult) {
			this.searchResult = searchResult;
		}

		@Override
		public Object getValue(String columnName) {
			if (ROW_NO_CONTEXT_VARIABLE.equals(columnName))
				return searchResult.getRow();
			else if (WINDOW_NAME_CONTEXT_VARIABLE.equals(columnName))
				return searchResult.getWindowName();
			else if (searchResult.getValueMap().containsKey(columnName))
				return searchResult.getValueMap().get(columnName);
			return null;
		}

		@Override
		public Object getProperty(String propertyName) {
			return null;
		}

		@Override
		public MColumn getColumn(String columnName) {
			if (searchResult.getValueMap().containsKey(columnName) && searchResult.getTableName() != null) {
				MTable table = MTable.get(Env.getCtx(), searchResult.getTableName());
				if (table != null) {
					return table.getColumn(columnName);
				}
			}
			return null;
		}

		@Override
		public String getTrxName() {
			return null;
		}
	}

	/**
	 * Parse markdown text inside html block
	 * 
	 * @param content
	 * @return parsed text
	 */
	private String parseMarkdownInHtmlBlock(String content) {
		return Core.getMarkdownRenderer().renderToHtml(content);
	}

	/**
	 * Add html content for 1 search result
	 * 
	 * @param result
	 * @param content
	 */
	private void addHtmlResult(SearchResult result, String content) {
		final Html resultHtml = new Html();
		resultHtml.setContent(content);
		ZkCssHelper.appendStyle(resultHtml, "display:inline-block");

		Div div = new Div();
		div.setSclass("search-result-box");
		if (result != null) {
			resultHtml.setAttribute(SEARCH_RESULT, result);
			resultHtml.addEventListener(Events.ON_CLICK, this);
		}
		// add @scope style
		if (result != null && result.getAD_Style_ID() > 0) {
			MStyle style = MStyle.get(result.getAD_Style_ID());
			String css = style.buildStyle(ThemeManager.getTheme(), new DefaultEvaluatee(), false);
			if (!Util.isEmpty(css, true)) {
				Style htmlStyle = new Style();
				htmlStyle.setContent("@scope {\n" + css + "\n}\n");
				div.appendChild(htmlStyle);
			}
		}
		div.appendChild(resultHtml);
		layout.appendChild(div);
	}

	/**
	 * Render buffered content
	 * 
	 * @param bufferedContent
	 * @param currentStyleId
	 * @param markdown
	 * @param footer
	 * @param result
	 * @param matchString
	 */
	private void renderBufferedContent(StringBuilder bufferedContent, int currentStyleId, Boolean markdown,
			String footer, SearchResult result, String matchString) {
		boolean isMarkdownMessage = markdown != null && markdown.booleanValue();
		if (!Util.isEmpty(footer, true)) {
			String formattedContent = parseMessageFormat(matchString, result, footer, isMarkdownMessage);
			if (bufferedContent.length() > 0)
				bufferedContent.append("\n");
			bufferedContent.append(formattedContent);
		}
		if (isMarkdownMessage) {
			String html = Core.getMarkdownRenderer().renderToHtml(bufferedContent.toString());
			addBufferedHtmlResult(html, currentStyleId);
		} else {
			addBufferedHtmlResult(bufferedContent.toString(), currentStyleId);
		}
	}

	/**
	 * Add html content for multiple search result that share the same AD_Message_ID
	 * format
	 * 
	 * @param content
	 * @param AD_Style_ID
	 */
	private void addBufferedHtmlResult(String content, int AD_Style_ID) {
		final Html resultHtml = new Html();
		resultHtml.setContent(content);

		Div div = new Div();
		div.setSclass("search-result-box");
		// add @scope style
		if (AD_Style_ID > 0) {
			MStyle style = MStyle.get(AD_Style_ID);
			String css = style.buildStyle(ThemeManager.getTheme(), new DefaultEvaluatee(), false);
			if (!Util.isEmpty(css, true)) {
				Style htmlStyle = new Style();
				htmlStyle.setContent("@scope {\n" + css + "\n}\n");
				div.appendChild(htmlStyle);
			}
		}
		div.appendChild(resultHtml);
		layout.appendChild(div);
	}

	/**
	 * Render search result that doesn't use AD_Message_ID formatting
	 * 
	 * @param matchString
	 * @param windowName
	 * @param result
	 * @return window name
	 */
	protected String renderSearchResult(String matchString, String windowName, SearchResult result) {
		// if have style, use div and @scope style
		Div div = null;
		if (result.getAD_Style_ID() > 0) {
			MStyle style = MStyle.get(result.getAD_Style_ID());
			String css = style.buildStyle(ThemeManager.getTheme(), new DefaultEvaluatee(), false);
			if (!Util.isEmpty(css, true)) {
				div = new Div();
				div.setSclass("search-result-box");
				Style htmlStyle = new Style();
				htmlStyle.setContent("@scope {\n" + css + "\n}\n");
				div.appendChild(htmlStyle);
				layout.appendChild(div);
			}
		}
		
		if (windowName == null || !windowName.equals(result.getWindowName())) {
			windowName = result.getWindowName();
			Label label = new Label(windowName);
			LayoutUtils.addSclass("window-name", label);
			if (div == null)
				layout.appendChild(label);
			else
				div.appendChild(label);
		}
		
		String content = result.getLabel();
		if (content.indexOf(MARKDOWN_OPENING_TAG) >= 0 && content.indexOf(MARKDOWN_CLOSING_TAG) > 0) {
			content = Core.getMarkdownRenderer().renderToHtml(content.replace(MARKDOWN_OPENING_TAG, "").replace(
					MARKDOWN_CLOSING_TAG, "").trim());
			addHtmlResult(result, content);
			return windowName;
		}
		
		A a = new A();
		a.setAttribute(SEARCH_RESULT, result);
		if (div == null) {
			layout.appendChild(a);
		} else {
			div.appendChild(a);
		}
		LayoutUtils.addSclass("search-result", a);
		a.addEventListener(Events.ON_CLICK, this);
		String label = result.getLabel();
		if (!Util.isEmpty(matchString, true)) {
			int match = label.toLowerCase().indexOf(matchString);
			while (match >= 0) {
				if (match > 0) {
					a.appendChild(new Label(label.substring(0, match)));
					Label l = new Label(label.substring(match, match + matchString.length()));
					LayoutUtils.addSclass("highlight", l);
					a.appendChild(l);
					label = label.substring(match + matchString.length());
				} else {
					Label l = new Label(label.substring(0, matchString.length()));
					LayoutUtils.addSclass("highlight", l);
					a.appendChild(l);
					label = label.substring(matchString.length());
				}
				match = label.toLowerCase().indexOf(matchString);
			}
		}
		if (label.length() > 0)
			a.appendChild(new Label(label));
		return windowName;
	}

	/**
	 * Perform search with searchString using definition from AD_SearchDefinition.
	 * 
	 * @param searchString
	 * @return List of {@link SearchResult}
	 */
	private List<SearchResult> doSearch(String searchString) {
		selected = -1;

		// Search with or without transaction code
		StringBuilder whereClause = new StringBuilder();
		String transactionCode = null;
		if (searchString != null && searchString.startsWith("/") && searchString.indexOf(" ") > 1) {
			// "/TransactionCode Search Text"
			transactionCode = searchString.substring(1, searchString.indexOf(" "));
			searchString = searchString.substring(searchString.indexOf(" ") + 1);
			whereClause.append("Upper(TransactionCode) = ?");
		} else {
			// Search with definition that doesn't use transaction code
			whereClause.append("TransactionCode IS NULL");
		}

		Query query = new Query(Env.getCtx(), I_AD_SearchDefinition.Table_Name, whereClause.toString(), null);
		if (transactionCode != null)
			query.setParameters(transactionCode.toUpperCase());
		List<MSearchDefinition> definitions = query.setOnlyActiveRecords(true).list();

		List<ISearchProvider> providers = Core.getSearchProviders();

		int pageSize = MSysConfig.getIntValue(
				MSysConfig.MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER, 3, Env.getAD_Client_ID(Env.getCtx()));
		for (MSearchDefinition msd : definitions) {
			for (ISearchProvider provider : providers) {
				if (provider.accept(msd)) {
					List<SearchResult> results = provider.search(msd, searchString, pageSize, 0);
					if (results != null) {
						list.addAll(results);
						break;
					}
				}
			}
		}
		return list;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			if (event.getTarget().getAttribute(SEARCH_RESULT) != null
					&& event.getTarget().getAttribute(SEARCH_RESULT) instanceof SearchResult result) {
				doZoom(result);
			}
		} else if (event.getName().equals(ON_SEARCH_DOCUMENTS_EVENT)) {
			onSearchDocuments((String) event.getData());
		}
	}

	/**
	 * Zoom to AD Window
	 * 
	 * @param result
	 */
	private void doZoom(SearchResult result) {
		MQuery query = new MQuery();
		query.addRestriction(result.getTableName() + "_ID", "=", result.getRecordId());
		AEnv.zoom(result.getWindowId(), query);
	}

	/**
	 * Find {@link SearchResult} link from {@link #layout} that matches text from
	 * textbox.
	 * <br/>
	 * Call {@link #doZoom(SearchResult)} if a match is found.
	 * 
	 * @param textbox
	 * @return true if a match is found
	 */
	public boolean onOk(Textbox textbox) {
		String text = textbox.getText();
		if (Util.isEmpty(text))
			return false;
		text = text.toLowerCase();
		int size = layout.getChildren().size();
		A firstStart = null;
		A exact = null;
		for (int i = 0; i < size; i++) {
			if (!(layout.getChildren().get(i) instanceof A))
				continue;
			A a = (A) layout.getChildren().get(i);
			SearchResult result = (SearchResult) a.getAttribute(SEARCH_RESULT);
			if (result.getLabel().equalsIgnoreCase(text)) {
				exact = a;
				break;
			} else if (text.equalsIgnoreCase(result.getName())) {
				exact = a;
				break;
			} else if (firstStart == null && result.getLabel().toLowerCase().startsWith(text) && text.length() >= 3) {
				firstStart = a;
			}
		}

		SearchResult result = null;
		if (exact != null)
			result = (SearchResult) exact.getAttribute(SEARCH_RESULT);
		else if (firstStart != null)
			result = (SearchResult) firstStart.getAttribute(SEARCH_RESULT);
		if (result != null) {
			doZoom(result);
			return true;
		}

		return false;
	}

	/**
	 * Select and return {@link SearchResult} that comes before the current selected
	 * {@link SearchResult} link in {@link #layout}.
	 * 
	 * @return {@link SearchResult}
	 */
	public SearchResult selectPrior() {
		if (selected > 0) {
			selected--;
			SearchResult result = list.get(selected);
			List<Component> links = layout.getChildren();
			for (Component link : links) {
				if (link instanceof A) {
					A a = (A) link;
					if (result.getLabel().equals(a.getLabel())) {
						a.setSclass("document-search-current-link");
					} else if ("document-search-current-link".equals(a.getSclass())) {
						a.setSclass(null);
					}
				}
			}
			return result;
		}
		return null;
	}

	/**
	 * Select and return {@link SearchResult} that comes after the current selected
	 * {@link SearchResult} link in {@link #layout}.
	 * 
	 * @return {@link SearchResult}
	 */
	public SearchResult selectNext() {
		if (selected < (list.size() - 1)) {
			selected++;
			SearchResult result = list.get(selected);
			List<Component> links = layout.getChildren();
			for (Component link : links) {
				if (link instanceof A) {
					A a = (A) link;
					if (result.getLabel().equals(a.getLabel())) {
						a.setSclass("document-search-current-link");
					} else if ("document-search-current-link".equals(a.getSclass())) {
						a.setSclass(null);
					}
				}
			}
			return result;
		}
		return null;
	}
}
