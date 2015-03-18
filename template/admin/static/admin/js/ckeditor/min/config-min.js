/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */
CKEDITOR.editorConfig=function(e){e.extraPlugins="sourcearea",e.toolbarGroups=[{name:"document",groups:["mode","document","doctools"]},{name:"clipboard",groups:["clipboard","undo"]},{name:"editing",groups:["find","selection","spellchecker"]},{name:"forms"},{name:"basicstyles",groups:["basicstyles","cleanup"]},{name:"paragraph",groups:["list","indent","blocks","align","bidi"]},{name:"links"},{name:"insert"},{name:"styles"},{name:"colors"},{name:"tools"},{name:"others"},{name:"about"}],e.removeButtons="Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript",e.allowedContent=!0,e.removeDialogTabs="link:advanced"};