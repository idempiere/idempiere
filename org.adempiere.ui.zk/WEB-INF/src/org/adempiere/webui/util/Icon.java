/******************************************************************************
 * Copyright (C) 2024 Zuhri Utama. A                                     *
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
package org.adempiere.webui.util;

public final class Icon {

    public static final String ACCOUNT                  = "Account";
    public static final String ARCHIVE                  = "Archive";
    public static final String ARROW                    = "arrow-alt";
    public static final String ASSIGNMENT               = "Assignment";
    public static final String ATTACHMENT               = "Attachment";
    public static final String BPARTNER                 = "BPartner";
    public static final String CALCULATOR               = "Calculator";
    public static final String CALENDAR                 = "Calendar";
    public static final String CANCEL                   = "Cancel";
    public static final String CHANGE_LOG               = "ChangeLog";
    public static final String COLLAPSING               = "Collapsing";
    public static final String COMMENT                  = "comment";
    public static final String CREATE_FROM              = "CreateFrom";
    public static final String CUSTOMIZE               = "Customize";
    public static final String DELETE                   = "Delete";
    public static final String DETAIL                   = "Detail";
    public static final String EDIT                     = "Edit";
    public static final String ENVELOPE                 = "envelope";
    public static final String ERASER                   = "Eraser";
    public static final String ERROR_MESSAGE_BOX        = "ErrorMessageBox";
    public static final String EXCLAMATION_MESSAGE_BOX  = "ExclamationMessageBox";
    public static final String EXCLUDE_SELECTED         = "ExcludeSelected";
    public static final String EXPAND                   = "Expand";
    public static final String EXPANDING                = "Expanding";
    public static final String EXPORT                   = "Export";
    public static final String FAST_BACK                = "FastBack";
    public static final String FAST_FORWARD             = "FastForward";
    public static final String FIELD_SUGGESTION         = "FieldSuggestion";
    public static final String FILE                     = "File";
    public static final String FILE_IMPORT              = "FileImport";
    public static final String FILE_ZIP                 = "file-zip-o";
    public static final String FIND                     = "Find";
    public static final String FOLDER                   = "Folder";
    public static final String FORM                     = "Form";
    public static final String GET_MAIL                 = "GetMail";
    public static final String HELP                     = "Help";
    public static final String HISTORY                  = "History";
    public static final String HOME                     = "Home";
    public static final String IGNORE                   = "Ignore";
    public static final String IMPORT                   = "Import";
    public static final String INCLUDE_SELECTED         = "IncludeSelected";
    public static final String INFO                     = "Info";
    public static final String INFO_ACCOUNT             = "InfoAccount";
    public static final String INFO_BPARTNER            = "InfoBPartner";
    public static final String INFORMATION_MESSAGE_BOX  = "InformationMessageBox";
    public static final String INFO_SCHEDULE            = "InfoSchedule";
    public static final String LIST_GROUP_CLOSE         = "listgroup-close";
    public static final String LIST_GROUP_OPEN          = "listgroup-open";
    public static final String LOCATOR                  = "Locator";
    public static final String LOCATION                 = "Location";
    public static final String LOCK                     = "lock";
    public static final String MAIL_REPLY               = "mail-reply";
    public static final String MORE                     = "More";
    public static final String MULTI                    = "Multi";
    public static final String NEW                      = "New";
    public static final String NEXT                     = "Next";
    public static final String NOT_ALLOWED              = "NotAllowed";
    public static final String OK                       = "Ok";
    public static final String ONLINE                   = "Online";
    public static final String OPEN                     = "Open";
    public static final String PARENT                   = "Parent";
    public static final String PATTRIBUTE               = "PAttribute";
    public static final String PAYMENT                  = "Payment";
    public static final String PENCIL                   = "Pencil";
    public static final String PREFERENCE               = "Preference";
    public static final String PREVIOUS                 = "Previous";
    public static final String PROCESS                  = "Process";
    public static final String PRODUCT                  = "Product";
    public static final String QUESTION_MESSAGE_BOX     = "QuestionMessageBox";
    public static final String QUICK_FORM               = "QuickForm";
    public static final String REFRESH                  = "Refresh";
    public static final String REMOVE                   = "Remove";
    public static final String REPORT                   = "Report";
    public static final String RE_RUN                   = "ReRun";
    public static final String RESET                    = "Reset";
    public static final String SAVE                     = "Save";
    public static final String SEARCH                   = "Search";
    public static final String SELECT_ALL               = "SelectAll";
    public static final String SEND_MAIL                = "SendMail";
    public static final String SEQUENCE_CHANGE          = "SequenceChange";
    public static final String SHARE                    = "Share";
    public static final String SHOW_MORE                = "ShowMore";
    public static final String SITEMAP                  = "sitemap";
    public static final String SPINNER                  = "spinner";
    public static final String STEP_BACK                = "StepBack";
    public static final String STEP_FORWARD             = "StepForward";
    public static final String TAB                      = "Tab";
    public static final String TASK                     = "Task";
    public static final String TH_LIST                  = "th-list";
    public static final String THREE_LINE_MENU          = "ThreeLineMenu";
    public static final String TRASH                    = "Trash";
    public static final String TREE_FAV_NODE_ADD        = "TreeFavNodeAdd";
    public static final String UNDO                     = "Undo";
    public static final String UNLOCK                   = "unlock";
    public static final String VPREFERENCE              = "VPreference";
    public static final String WINDOW                   = "Window";
    public static final String WIZARD                   = "Wizard";
    public static final String WORKFLOW                 = "Workflow";
    public static final String ZOOM                     = "Zoom";

    private Icon() {}

    public static String getIconSclass(String name) {
        return "z-icon-" + name;
    }
}
