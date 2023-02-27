import 'package:flutter/material.dart';
import 'dart:core';
import './dropdown/dropdown_dialog.dart';
import './dropdown/helper_classes.dart';
import './dropdown/prepare_widget.dart';
import './dropdown/constants.dart';

/// SearchChoices widget that allows the opening of a searchable dropdown.
/// Use the [SearchChoices.single] factory if only one item needs to be
/// selected.
/// Use the [SearchChoices.multiple] factory if user must be able to select
/// multiple items at once.
class SearchChoices<T> extends FormField<T> {
  /// [dialogBoxMenuWrapper] [Function] called to wrap the menu widget when
  /// in dialog box mode. This is useful for testing mainly.
  static Widget Function(Widget)? dialogBoxMenuWrapper;

  /// [items] with __child__: [Widget] displayed ; __value__: any object with
  /// .toString() used to match search keyword.
  final List<DropdownMenuItem<T>>? items;

  /// [onChanged] [Function] with parameter: __value__ not returning executed
  /// after the selection is done.
  final Function? onChanged;

  /// [value] value to be preselected.
  final T? value;

  /// [style] used for the hint if it is given is [String].
  final TextStyle? style;

  /// [searchHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed at the top of the search dialog box.
  final dynamic searchHint;

  /// [hint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed before any value is selected or after the
  /// selection is cleared.
  final dynamic hint;

  /// [disabledHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed instead of hint when the widget is displayed.
  final dynamic disabledHint;

  /// [icon] [String]|[Widget]|[Function] with parameter: __value__ returning
  /// [String]|[Widget] displayed next to the selected item or the hint if none.
  final dynamic icon;

  /// [underline] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed below the selected item or the hint
  /// if none.
  final dynamic underline;

  /// [doneButton] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed at the top of the search dialog box.
  final dynamic doneButton;

  /// [label] [String]|[Widget]|[Function] with parameter: __value__ returning
  /// [String]|[Widget] displayed above the selected item or the hint if none.
  final dynamic label;

  /// [closeButton] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed at the bottom of the search dialog
  /// box.
  final dynamic closeButton;

  /// [displayClearIcon] whether or not to display an icon to clear the selected
  /// value.
  final bool displayClearIcon;

  /// [clearIcon] [Icon] to be used for clearing the selected value.
  final Icon clearIcon;

  /// [iconEnabledColor] [Color] to be used for enabled icons.
  final Color? iconEnabledColor;

  /// [iconDisabledColor] [Color] to be used for disabled icons.
  final Color? iconDisabledColor;

  /// [iconSize] for the icons next to the selected value (icon and clearIcon).
  final double iconSize;

  /// [isExpanded] can be necessary to avoid pixel overflows (zebra symptom).
  final bool isExpanded;

  /// [isCaseSensitiveSearch] only used when searchFn is not specified.
  final bool isCaseSensitiveSearch;

  /// [searchFn] [Function] with parameters: __keyword__, __items__ returning
  /// [List<int>] as the list of indexes for the items to be displayed.
  final Function? searchFn;

  /// [onClear] [Function] with no parameter not returning executed when the
  /// clear icon is tapped.
  final Function? onClear;

  /// [selectedValueWidgetFn] [Function] with parameter: __item__ returning
  /// [Widget] to be used to display the selected value.
  final Function? selectedValueWidgetFn;

  /// [keyboardType] used for the search.
  final TextInputType keyboardType;

  /// [validator] [Function] with parameter: __value__ returning [String]
  /// displayed below selected value when not valid and null when valid.
  final String? Function(T?)? validator;

  /// [multipleSelection] indicates whether user can select one or more items.
  final bool multipleSelection;

  /// [selectedItems] indexes of items to be preselected.
  final List selectedItems;

  /// [displayItem] [Function] with parameters: __item__, __selected__ returning
  /// [Widget] to be displayed in the search list.
  final Function? displayItem;

  /// [dialogBox] whether the search should be displayed as a dialog box or as a
  /// menu below the selected value if any.
  final bool dialogBox;

  /// [menuConstraints] [BoxConstraints] used to define the zone where to
  /// display the search menu. Example:
  /// BoxConstraints.tight(Size.fromHeight(250)) .
  /// Not to be used for dialogBox = true.
  final BoxConstraints? menuConstraints;

  /// [readOnly] [bool] whether to let the user choose the value to select or
  /// just present the selected value if any.
  final bool readOnly;

  /// [menuBackgroundColor] [Color] background color of the menu whether in
  /// dialog box or menu mode.
  final Color? menuBackgroundColor;

  /// [rightToLeft] [bool] mirrors the widgets display for right to left
  /// languages defaulted to false.
  final bool rightToLeft;

  /// [autofocus] [bool] automatically focuses on the search field bringing up
  /// the keyboard defaulted to true.
  final bool autofocus;

  /// [selectedAggregateWidgetFn] [Function] with parameter: __list of widgets
  /// presenting selected values__ , returning [Widget] to be displayed to
  /// present the selected items.
  final Function? selectedAggregateWidgetFn;

  /// [padding] [double] or [EdgeInsets] sets the padding around the
  /// DropdownButton, defaulted to 10.0.
  final dynamic padding;

  /// [setOpenDialog] [Function] sets the function to call to set the function
  /// to call in order to open the dialog with the search terms string as a
  /// parameter, defaulted to null.
  final Function? setOpenDialog;

  /// [buildDropDownDialog] [Function] controls the layout of the dropdown
  /// dialog.
  /// If null, equivalent to:
  /// ```
  /// (Widget titleBar, Widget searchBar, Widget list, Widget closeButton,
  /// BuildContext dropDownContext,){
  /// return AnimatedContainer(
  ///      padding: MediaQuery.of(dropDownContext).viewInsets,
  ///      duration: const Duration(milliseconds: 300),
  ///      child: Card(
  ///        color: widget.menuBackgroundColor,
  ///        margin: EdgeInsets.symmetric(
  ///            vertical: widget.dialogBox ? 10 : 5,
  ///            horizontal: widget.dialogBox ? 10 : 4),
  ///        child: Container(
  ///          constraints: widget.menuConstraints,
  ///          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
  ///          child: Column(
  ///            mainAxisAlignment: MainAxisAlignment.start,
  ///            crossAxisAlignment: CrossAxisAlignment.start,
  ///            mainAxisSize: MainAxisSize.min,
  ///            children: <Widget>[
  ///              titleBar,
  ///              searchBar,
  ///              list,
  ///              closeButton,
  ///            ],
  ///          ),
  ///        ),
  ///      ),
  ///    );
  /// }
  /// ```
  final Widget Function(
    Widget titleBar,
    Widget searchBar,
    Widget list,
    Widget closeButton,
    BuildContext dropDownContext,
  )? buildDropDownDialog;

  /// [dropDownDialogPadding] [EdgeInsets] sets the padding between the screen
  /// and the dialog.
  final EdgeInsets? dropDownDialogPadding;

  /// [searchInputDecoration] [InputDecoration] sets the search bar decoration.
  final InputDecoration? searchInputDecoration;

  /// [itemsPerPage] [int] if set, organizes the search list per page with the
  /// given number of items displayed per page. Must give [currentPage].
  final int? itemsPerPage;

  /// [currentPage] [PointerThisPlease<int>] if [itemsPerPage] is set, holds the
  /// page number for the search items to be displayed.
  final PointerThisPlease<int>? currentPage;

  /// [customPaginationDisplay] Widget Function(Widget listWidget, int
  /// totalFilteredItemsNb, Function updateSearchPage) if [itemsPerPage] is set,
  /// customizes the display and the handling of the pagination on the search
  /// list.
  final Widget Function(Widget listWidget, int totalFilteredItemsNb,
      Function updateSearchPage)? customPaginationDisplay;

  /// [futureSearchFn] Future<int> Function(String keyword,
  /// List<DropdownMenuItem> itemsListToClearAndFill, int pageNb) used to
  /// search items from the network. Must return items (up to [itemsPerPage] if
  /// set). Must return an [int] with the total number of results (allows the
  /// handling of pagination).
  final Future<Tuple2<List<DropdownMenuItem>, int>> Function(
      String? keyword,
      String? orderBy,
      bool? orderAsc,
      List<Tuple2<String, String>>? filters,
      int? pageNb)? futureSearchFn;

  /// [futureSearchOrderOptions] [Map<String, Map<String,dynamic>>] when
  /// [futureSearchFn] is set, can be used to display search order options
  /// specified in the form
  /// {"order1Name":{"icon":order1IconWidget,"asc":true},}. Please refer to the
  /// documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  final Map<String, Map<String, dynamic>>? futureSearchOrderOptions;

  /// [futureSearchFilterOptions] [Map<String, Map<String, Object>>] when
  /// [futureSearchFn] is set, can be used to display search filters specified
  /// in the form
  /// {"filter1Name":
  /// {"icon":filter1IconWidget,
  /// "values":["value1",{"value2":filter1Value2Widget}}}.
  /// Please refer to the documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  final Map<String, Map<String, Object>>? futureSearchFilterOptions;

  /// [futureSelectedValues] [List<T>] contains the list of selected values in
  /// case of future search in multiple selection mode.
  final List<T>? futureSelectedValues;

  /// [emptyListWidget] [String]|[Widget]|[Function] with parameter: __keyword__
  /// returning [String]|[Widget] displayed instead of the list of items in case
  /// it is empty.
  final dynamic emptyListWidget;

  /// [onTap] [Function] called when the user clicks on the Widget before it
  /// opens the dialog or the menu. Note that this is not called in case the
  /// Widget is disabled.
  final Function? onTap;

  /// [futureSearchRetryButton] [Function] called to customize the Error - retry
  /// button displayed when there is an issue with the future search.
  final Function? futureSearchRetryButton;

  /// [searchDelay] [int] in milliseconds applied before the search is
  /// initiated. This applies to future and non-future searches.
  final int? searchDelay;

  /// [fieldPresentationFn] [Function] returning a Widget to customize the
  /// display of the field.
  final Widget Function(Widget fieldWidget, {bool selectionIsValid})?
      fieldPresentationFn;

  /// [fieldDecoration] [Decoration] is the decoration of the SearchChoices
  /// Widget while displaying the hints or the selected values.
  /// Should differ when selection is not valid.
  final Decoration? fieldDecoration;

  /// [clearSearchIcon] [Widget] sets the icon to be used to clear the search.
  final Widget? clearSearchIcon;

  /// [showDialogFn] [Function] allows the control of the dialog display.
  final Future<void> Function(
    BuildContext context,
    Widget Function({
      String searchTerms,
    })
        menuWidget,
    String searchTerms,
  )? showDialogFn;

  /// [onSaved] as in FormField.
  final FormFieldSetter<T>? onSaved;

  /// [listValidator] [Function] with parameter: __List__ returning [String]
  /// displayed below selected value when not valid and null when valid.
  final String? Function(List<T?>)? listValidator;

  /// [autovalidateMode] as in FormField.
  final AutovalidateMode autovalidateMode;

  /// [restorationId] as in FormField.
  final String? restorationId;

  /// [giveMeThePop] [Function] to pass the pop function so that the menu or
  /// dialog can be closed from outside the widget.
  final Function(Function pop)? giveMeThePop;

  /// Search choices Widget with a single choice that opens a dialog or a menu
  /// to let the user do the selection conveniently with a search.
  ///
  /// * [items] with __child__: [Widget] displayed ; __value__: any object with
  /// .toString() used to match search keyword.
  /// * [onChanged] [Function] with parameter: __value__ not returning executed
  /// after the selection is done.
  /// * [value] value to be preselected.
  /// * [style] used for the hint if it is given is [String].
  /// * [searchHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed at the top of the search dialog box.
  /// * [hint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed before any value is selected or after the
  /// selection is cleared.
  /// * [disabledHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// * [icon] [String]|[Widget]|[Function] with parameter: __value__ returning
  /// [String]|[Widget] displayed next to the selected item or the hint if none.
  /// * [underline] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed below the selected item or the hint
  /// if none.
  /// * [doneButton] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed at the top of the search dialog box.
  /// * [label] [String]|[Widget]|[Function] with parameter: __value__ returning
  /// [String]|[Widget] displayed above the selected item or the hint if none.
  /// * [closeButton] [String]|[Widget]|[Function] with parameter: __value__
  /// returning [String]|[Widget] displayed at the bottom of the search dialog
  /// box.
  /// * [displayClearIcon] whether or not to display an icon to clear the
  /// selected value.
  /// * [clearIcon] [Icon] to be used for clearing the selected value.
  /// * [iconEnabledColor] [Color] to be used for enabled icons.
  /// * [iconDisabledColor] [Color] to be used for disabled icons.
  /// * [iconSize] for the icons next to the selected value
  /// (icon and clearIcon).
  /// * [isExpanded] can be necessary to avoid pixel overflows (zebra symptom).
  /// * [isCaseSensitiveSearch] only used when searchFn is not specified.
  /// * [searchFn] [Function] with parameters: __keyword__, __items__ returning
  /// [List<int>] as the list of indexes for the items to be displayed.
  /// * [onClear] [Function] with no parameter not returning executed when the
  /// clear icon is tapped.
  /// * [selectedValueWidgetFn] [Function] with parameter: __item__ returning
  /// [Widget] to be used to display the selected value.
  /// * [keyboardType] used for the search.
  /// * [validator] [Function] with parameter: __value__ returning [String]
  /// displayed below selected value when not valid and null when valid.
  /// * [assertUniqueValue] whether to run a consistency check of the list of
  /// items.
  /// * [displayItem] [Function] with parameters: __item__, __selected__
  /// returning [Widget] to be displayed in the search list.
  /// * [dialogBox] whether the search should be displayed as a dialog box or as
  /// a menu below the selected value if any.
  /// * [menuConstraints] [BoxConstraints] used to define the zone where to
  /// display the search menu. Example:
  /// BoxConstraints.tight(Size.fromHeight(250)) .
  /// Not to be used for dialogBox = true.
  /// * [readOnly] [bool] whether to let the user choose the value to select or
  /// just present the selected value if any.
  /// * [menuBackgroundColor] [Color] background color of the menu whether in
  /// dialog box or menu mode.
  /// * [rightToLeft] [bool] mirrors the widgets display for right to left
  /// languages defaulted to false.
  /// * [autofocus] [bool] automatically focuses on the search field bringing up
  /// the keyboard defaulted to true.
  /// * [selectedAggregateWidgetFn] [Function] with parameter: __list of widgets
  /// presenting selected values__ , returning [Widget] to be displayed to
  /// present the selected items.
  /// * [padding] [double] or [EdgeInsets] sets the padding around the
  /// DropdownButton, defaulted to 10.0.
  /// * [setOpenDialog] [Function] sets the function to call to set the function
  /// to call in order to open the dialog with the search terms string as a
  /// parameter, defaulted to null.
  /// * [buildDropDownDialog] [Function] controls the layout of the dropdown
  /// dialog.
  /// * [dropDownDialogPadding] [EdgeInsets] sets the padding between the screen
  /// and the dialog.
  /// * [searchInputDecoration] [InputDecoration] sets the search bar
  /// decoration.
  /// * [itemsPerPage] [int] if set, organizes the search list per page with the
  /// given number of items displayed per page.
  /// * [currentPage] [PointerThisPlease<int>] if [itemsPerPage] is set, holds
  /// the page number for the search items to be displayed.
  /// * [customPaginationDisplay] Widget Function(Widget listWidget,
  /// int totalFilteredItemsNb, Function updateSearchPage)
  /// if [itemsPerPage] is set, customizes the display and the handling of the
  /// pagination on the search list.
  /// * [futureSearchFn] Future<int> Function(String keyword,
  /// List<DropdownMenuItem> itemsListToClearAndFill, int pageNb) used to
  /// search items from the network. Must return items(up to [itemsPerPage] if
  /// set). Must return an [int] with the total number of results (allows the
  /// handling of pagination).
  /// * [futureSearchOrderOptions] [Map<String, Map<String,dynamic>>] when
  /// [futureSearchFn] is set, can be used to display search order options
  /// specified in the form
  /// {"order1Name":{"icon":order1IconWidget,"asc":true},}. Please refer to the
  /// documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  /// * [futureSearchFilterOptions] [Map<String, Map<String, Object>>] when
  /// [futureSearchFn] is set, can be used to display search filters specified
  /// in the form
  /// {"filter1Name":
  /// {"icon":filter1IconWidget,
  /// "values":["value1",{"value2":filter1Value2Widget}}}.
  /// Please refer to the documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  /// * [emptyListWidget] [String]|[Widget]|[Function] with parameter:
  /// __keyword__ returning [String]|[Widget] displayed instead of the list of
  /// items in case it is empty.
  /// * [onTap] [Function] called when the user clicks on the Widget before it
  /// opens the dialog or the menu. Note that this is not called in case the
  /// Widget is disabled.
  /// * [futureSearchRetryButton] [Function] called to customize the Error -
  /// retry button displayed when there is an issue with the future search.
  /// * [searchDelay] [int] in milliseconds applied before the search is
  /// initiated. This applies to future and non-future searches.
  /// * [fieldPresentationFn] [Function] returning a Widget to customize the
  /// display of the field.
  /// * [fieldDecoration] [Decoration] is the decoration of the SearchChoices
  /// Widget while displaying the hints or the selected values.
  /// Should differ when selection is not valid.
  /// * [clearSearchIcon] [Widget] sets the icon to be used to clear the search.
  /// * [showDialogFn] [Function] allows the control of the dialog display.
  /// * [onSaved] as in FormField.
  /// * [listValidator] [Function] with parameter: __List__ returning [String]
  /// displayed below selected value when not valid and null when valid.
  /// * [autovalidateMode] as in FormField.
  /// * [restorationId] as in FormField.
  /// * [giveMeThePop] [Function] to pass the pop function so that the menu or
  /// dialog can be closed from outside the widget.
  factory SearchChoices.single({
    Key? key,
    List<DropdownMenuItem<T>>? items,
    Function? onChanged,
    T? value,
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton,
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    String? Function(T?)? validator,
    bool assertUniqueValue = true,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
    bool rightToLeft = false,
    bool autofocus = true,
    Function? selectedAggregateWidgetFn,
    dynamic padding,
    Function? setOpenDialog,
    Widget Function(
      Widget titleBar,
      Widget searchBar,
      Widget list,
      Widget closeButton,
      BuildContext dropDownContext,
    )?
        buildDropDownDialog,
    EdgeInsets? dropDownDialogPadding,
    InputDecoration? searchInputDecoration,
    int? itemsPerPage,
    PointerThisPlease<int>? currentPage,
    Widget Function(Widget listWidget, int totalFilteredItemsNb,
            Function updateSearchPage)?
        customPaginationDisplay,
    Future<Tuple2<List<DropdownMenuItem>, int>> Function(
            String? keyword,
            String? orderBy,
            bool? orderAsc,
            List<Tuple2<String, String>>? filters,
            int? pageNb)?
        futureSearchFn,
    Map<String, Map<String, dynamic>>? futureSearchOrderOptions,
    Map<String, Map<String, Object>>? futureSearchFilterOptions,
    dynamic emptyListWidget,
    Function? onTap,
    Function? futureSearchRetryButton,
    int? searchDelay,
    Widget Function(Widget fieldWidget, {bool selectionIsValid})?
        fieldPresentationFn,
    Decoration? fieldDecoration,
    Widget? clearSearchIcon,
    Future<void> Function(
      BuildContext context,
      Widget Function({
        String searchTerms,
      })
          menuWidget,
      String searchTerms,
    )?
        showDialogFn,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    String? restorationId,
    Function(Function pop)? giveMeThePop,
  }) {
    return (SearchChoices._(
      key: key,
      items: items,
      onChanged: onChanged,
      value: value,
      style: style,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor,
      iconDisabledColor: iconDisabledColor,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn,
      multipleSelection: false,
      doneButton: doneButton,
      displayItem: displayItem,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor,
      rightToLeft: rightToLeft,
      autofocus: autofocus,
      selectedAggregateWidgetFn: selectedAggregateWidgetFn,
      padding: padding,
      setOpenDialog: setOpenDialog,
      buildDropDownDialog: buildDropDownDialog,
      dropDownDialogPadding: dropDownDialogPadding,
      searchInputDecoration: searchInputDecoration,
      itemsPerPage: itemsPerPage,
      currentPage: currentPage,
      customPaginationDisplay: customPaginationDisplay,
      futureSearchFn: futureSearchFn,
      futureSearchOrderOptions: futureSearchOrderOptions,
      futureSearchFilterOptions: futureSearchFilterOptions,
      emptyListWidget: emptyListWidget,
      onTap: onTap,
      futureSearchRetryButton: futureSearchRetryButton,
      searchDelay: searchDelay,
      fieldPresentationFn: fieldPresentationFn,
      fieldDecoration: fieldDecoration,
      clearSearchIcon: clearSearchIcon,
      showDialogFn: showDialogFn,
      onSaved: onSaved,
      autovalidateMode: autovalidateMode,
      restorationId: restorationId,
      giveMeThePop: giveMeThePop,
    ));
  }

  /// Search choices Widget with a multiple choice that opens a dialog or a menu
  /// to let the user do the selection conveniently with a search.
  ///
  /// * [items] with __child__: [Widget] displayed ; __value__: any object with
  /// .toString() used to match search keyword.
  /// * [onChanged] [Function] with parameter: __selectedItems__ not returning
  /// executed after the selection is done.
  /// * [selectedItems] indexes of items to be preselected.
  /// * [style] used for the hint if it is given is [String].
  /// * [searchHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed at the top of the search dialog box.
  /// * [hint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed before any value is selected or after the
  /// selection is cleared.
  /// * [disabledHint] [String]|[Widget]|[Function] with no parameter returning
  /// [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// * [icon] [String]|[Widget]|[Function] with parameter: __selectedItems__
  /// returning [String]|[Widget] displayed next to the selected items or the
  /// hint if none.
  /// * [underline] [String]|[Widget]|[Function] with parameter:
  /// __selectedItems__ returning [String]|[Widget] displayed below the selected
  /// items or the hint if none.
  /// * [doneButton] [String]|[Widget]|[Function] with parameter:
  /// __selectedItems__ returning [String]|[Widget] displayed at the top of the
  /// search dialog box. Cannot be null in multiple selection mode.
  /// * [label] [String]|[Widget]|[Function] with parameter: __selectedItems__
  /// returning [String]|[Widget] displayed above the selected items or the hint
  /// if none.
  /// * [closeButton] [String]|[Widget]|[Function] with parameter:
  /// __selectedItems__ returning [String]|[Widget] displayed at the bottom of
  /// the search dialog box.
  /// * [displayClearIcon] whether or not to display an icon to clear the
  /// selected values.
  /// * [clearIcon] [Icon] to be used for clearing the selected values.
  /// * [iconEnabledColor] [Color] to be used for enabled icons.
  /// * [iconDisabledColor] [Color] to be used for disabled icons.
  /// * [iconSize] for the icons next to the selected values (icon and
  /// clearIcon).
  /// * [isExpanded] can be necessary to avoid pixel overflows (zebra symptom).
  /// * [isCaseSensitiveSearch] only used when searchFn is not specified.
  /// * [searchFn] [Function] with parameters: __keyword__, __items__ returning
  /// [List<int>] as the list of indexes for the items to be displayed.
  /// * [onClear] [Function] with no parameter not returning executed when the
  /// clear icon is tapped.
  /// * [selectedValueWidgetFn] [Function] with parameter: __item__ returning
  /// [Widget] to be used to display the selected values.
  /// * [keyboardType] used for the search.
  /// * [validator] [Function] with parameter: __selectedItems__ returning
  /// [String] displayed below selected values when not valid and null when
  /// valid.
  /// * [displayItem] [Function] with parameters: __item__, __selected__
  /// returning [Widget] to be displayed in the search list.
  /// * [dialogBox] whether the search should be displayed as a dialog box or as
  /// a menu below the selected values if any.
  /// * [menuConstraints] [BoxConstraints] used to define the zone where to
  /// display the search menu. Example:
  /// BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for
  /// dialogBox = true.
  /// * [readOnly] [bool] whether to let the user choose the value to select or
  /// just present the selected value if any.
  /// * [menuBackgroundColor] [Color] background color of the menu whether in
  /// dialog box or menu mode.
  /// * [rightToLeft] [bool] mirrors the widgets display for right to left
  /// languages defaulted to false.
  /// * [autofocus] [bool] automatically focuses on the search field bringing up
  /// the keyboard defaulted to true.
  /// * [selectedAggregateWidgetFn] [Function] with parameter: __list of widgets
  /// presenting selected values__ , returning [Widget] to be displayed to
  /// present the selected items.
  /// * [padding] [double] or [EdgeInsets] sets the padding around the
  /// DropdownButton, defaulted to 10.0.
  /// * [setOpenDialog] [Function] sets the function to call to set the function
  /// to call in order to open the dialog with the search terms string as a
  /// parameter, defaulted to null.
  /// * [buildDropDownDialog] [Function] controls the layout of the dropdown
  /// dialog.
  /// * [dropDownDialogPadding] [EdgeInsets] sets the padding between the screen
  /// and the dialog.
  /// * [searchInputDecoration] [InputDecoration] sets the search bar
  /// decoration.
  /// * [itemsPerPage] [int] if set, organizes the search list per page with the
  /// given number of items displayed per page.
  /// * [currentPage] [int] if [itemsPerPage] is set, holds the page number for
  /// the search items to be displayed.
  /// * [customPaginationDisplay] Widget Function(Widget listWidget,
  /// int totalFilteredItemsNb, Function updateSearchPage) if [itemsPerPage] is
  /// set, customizes the display and the handling of the pagination on the
  /// search list.
  /// * [futureSearchFn] Future<int> Function(String keyword,
  /// List<DropdownMenuItem> itemsListToClearAndFill, int pageNb) used to
  /// search items from the network. Must return items (up to [itemsPerPage] if
  /// set). Must return an [int] with the total number of results (allows the
  /// handling of pagination).
  /// * [futureSearchOrderOptions] [Map<String, Map<String,dynamic>>] when
  /// [futureSearchFn] is set, can be used to display search order options
  /// specified in the form
  /// {"order1Name":{"icon":order1IconWidget,"asc":true},}. Please refer to the
  /// documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  /// * [futureSearchFilterOptions] [Map<String, Map<String, Object>>] when
  /// [futureSearchFn] is set, can be used to display search filters specified
  /// in the form
  /// {"filter1Name":
  /// {"icon":filter1IconWidget,
  /// "values":["value1",{"value2":filter1Value2Widget}}}.
  /// Please refer to the documentation example:
  /// https://github.com/lcuis/search_choices/blob/master/example/lib/main.dart.
  /// * [futureSelectedValues] [List<T>] contains the list of selected values in
  /// case of future search in multiple selection mode.
  /// * [emptyListWidget] [String]|[Widget]|[Function] with parameter:
  /// __keyword__ returning [String]|[Widget] displayed instead of the list of
  /// items in case it is empty.
  /// * [onTap] [Function] called when the user clicks on the Widget before it
  /// opens the dialog or the menu. Note that this is not called in case the
  /// Widget is disabled.
  /// * [futureSearchRetryButton] [Function] called to customize the Error -
  /// retry button displayed when there is an issue with the future search.
  /// * [searchDelay] [int] in milliseconds applied before the search is
  /// initiated. This applies to future and non-future searches.
  /// * [fieldPresentationFn] [Function] returning a Widget to customize the
  /// display of the field.
  /// * [fieldDecoration] [Decoration] is the decoration of the SearchChoices
  /// Widget while displaying the hints or the selected values.
  /// Should differ when selection is not valid.
  /// * [clearSearchIcon] [Widget] sets the icon to be used to clear the search.
  /// [showDialogFn] [Function] allows the control of the dialog display.
  /// * [listValidator] [Function] with parameter: __List__ returning [String]
  /// displayed below selected value when not valid and null when valid.
  factory SearchChoices.multiple({
    Key? key,
    List<DropdownMenuItem<T>>? items,
    Function? onChanged,
    List selectedItems = const [],
    TextStyle? style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton = "Done",
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color? iconEnabledColor,
    Color? iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function? searchFn,
    Function? onClear,
    Function? selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    String? Function(T?)? validator,
    Function? displayItem,
    bool dialogBox = true,
    BoxConstraints? menuConstraints,
    bool readOnly = false,
    Color? menuBackgroundColor,
    bool rightToLeft = false,
    bool autofocus = true,
    Function? selectedAggregateWidgetFn,
    dynamic padding,
    Function? setOpenDialog,
    Widget Function(
      Widget titleBar,
      Widget searchBar,
      Widget list,
      Widget closeButton,
      BuildContext dropDownContext,
    )?
        buildDropDownDialog,
    EdgeInsets? dropDownDialogPadding,
    InputDecoration? searchInputDecoration,
    int? itemsPerPage,
    PointerThisPlease<int>? currentPage,
    Widget Function(Widget listWidget, int totalFilteredItemsNb,
            Function updateSearchPage)?
        customPaginationDisplay,
    Future<Tuple2<List<DropdownMenuItem>, int>> Function(
            String? keyword,
            String? orderBy,
            bool? orderAsc,
            List<Tuple2<String, String>>? filters,
            int? pageNb)?
        futureSearchFn,
    Map<String, Map<String, dynamic>>? futureSearchOrderOptions,
    Map<String, Map<String, Object>>? futureSearchFilterOptions,
    List<T>? futureSelectedValues,
    dynamic emptyListWidget,
    Function? onTap,
    Function? futureSearchRetryButton,
    int? searchDelay,
    Widget Function(Widget fieldWidget, {bool selectionIsValid})?
        fieldPresentationFn,
    Decoration? fieldDecoration,
    Widget? clearSearchIcon,
    Future<void> Function(
      BuildContext context,
      Widget Function({
        String searchTerms,
      })
          menuWidget,
      String searchTerms,
    )?
        showDialogFn,
    FormFieldSetter<T>? onSaved,
    String? Function(List<dynamic>)? listValidator,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    String? restorationId,
    Function(Function pop)? giveMeThePop,
  }) {
    return (SearchChoices._(
      key: key,
      items: items,
      style: style,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor,
      iconDisabledColor: iconDisabledColor,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn,
      multipleSelection: true,
      selectedItems: selectedItems,
      doneButton: doneButton,
      onChanged: onChanged,
      displayItem: displayItem,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor,
      rightToLeft: rightToLeft,
      autofocus: autofocus,
      selectedAggregateWidgetFn: selectedAggregateWidgetFn,
      padding: padding,
      setOpenDialog: setOpenDialog,
      buildDropDownDialog: buildDropDownDialog,
      dropDownDialogPadding: dropDownDialogPadding,
      searchInputDecoration: searchInputDecoration,
      itemsPerPage: itemsPerPage,
      currentPage: currentPage,
      customPaginationDisplay: customPaginationDisplay,
      futureSearchFn: futureSearchFn,
      futureSearchOrderOptions: futureSearchOrderOptions,
      futureSearchFilterOptions: futureSearchFilterOptions,
      futureSelectedValues: futureSelectedValues,
      emptyListWidget: emptyListWidget,
      onTap: onTap,
      futureSearchRetryButton: futureSearchRetryButton,
      searchDelay: searchDelay,
      fieldPresentationFn: fieldPresentationFn,
      fieldDecoration: fieldDecoration,
      clearSearchIcon: clearSearchIcon,
      showDialogFn: showDialogFn,
      onSaved: onSaved,
      listValidator: listValidator,
      autovalidateMode: autovalidateMode,
      restorationId: restorationId,
      giveMeThePop: giveMeThePop,
    ));
  }

  bool get isEnabled =>
      (items?.isNotEmpty ?? false || futureSearchFn != null) &&
      (onChanged != null || onChanged is Function);

  SearchChoices._({
    Key? key,
    this.items,
    this.onChanged,
    this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon,
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.displayClearIcon = true,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    required this.dialogBox,
    this.menuConstraints,
    required this.readOnly,
    this.menuBackgroundColor,
    required this.rightToLeft,
    required this.autofocus,
    this.selectedAggregateWidgetFn,
    this.padding,
    this.setOpenDialog,
    this.buildDropDownDialog,
    this.dropDownDialogPadding,
    this.searchInputDecoration,
    this.itemsPerPage,
    this.currentPage,
    this.customPaginationDisplay,
    this.futureSearchFn,
    this.futureSearchOrderOptions,
    this.futureSearchFilterOptions,
    this.futureSelectedValues,
    this.emptyListWidget,
    this.onTap,
    this.futureSearchRetryButton,
    this.searchDelay,
    this.fieldPresentationFn,
    this.fieldDecoration,
    this.clearSearchIcon,
    this.showDialogFn,
    this.onSaved,
    this.listValidator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.restorationId,
    this.giveMeThePop,
  })  : assert(!multipleSelection || doneButton != null),
        assert(menuConstraints == null || !dialogBox),
        assert(itemsPerPage == null || currentPage != null,
            "currentPage must be given if itemsPerPage is given"),
        assert(
            dropDownDialogPadding == null || buildDropDownDialog == null,
            "buildDropDownDialog and dropDownDialogPadding cannot be set at" +
                " the same time"),
        assert(dialogBox || dropDownDialogPadding == null,
            "dropDownDialogPadding must be null if dialogBox == false"),
        assert(
            futureSearchOrderOptions == null || futureSearchFn != null,
            "futureSearchOrderOptions is of no use if futureSearchFn is not " +
                "set"),
        assert(
            futureSearchFilterOptions == null || futureSearchFn != null,
            "futureSearchFilterOptions is of no use if futureSearchFn is not " +
                "set"),
        assert(futureSearchFn == null || searchFn == null,
            "futureSearchFn and searchFn cannot work together"),
        assert((futureSearchFn == null) != (items == null),
            "must either have futureSearchFn or items but not both"),
        assert(
            futureSearchFn == null ||
                (multipleSelection
                    ? (futureSelectedValues != null && value == null)
                    : (true && futureSelectedValues == null)),
            "${multipleSelection ? "futureSelectedValues" : "value"} must be " +
                "set if futureSearchFn is set in " +
                "${multipleSelection ? "multiple" : "single"} selection mode " +
                "while " +
                "${multipleSelection ? "value" : "futureSelectedValues"} " +
                "must not be set"),
        assert(fieldDecoration == null || underline == null,
            "use either underline or fieldDecoration"),
        assert(fieldPresentationFn == null || underline == null,
            "use either underline or fieldPresentationFn"),
        assert(fieldDecoration == null || padding == null,
            "use either padding or fieldDecoration"),
        assert(fieldPresentationFn == null || padding == null,
            "use either padding or fieldPresentationFn"),
        assert(dialogBox || showDialogFn == null,
            "use showDialogFn only with dialogBox"),
        super(
          key: key,
          builder: (FormFieldState<dynamic> state) {
            _SearchChoicesState<T> sCState = state as _SearchChoicesState<T>;
            return (sCState.buildWidget(sCState.context));
          },
          onSaved: onSaved,
          validator: validator,
          initialValue: value,
          enabled: (items?.isNotEmpty ?? false || futureSearchFn != null) &&
              (onChanged != null || onChanged is Function),
          autovalidateMode: autovalidateMode,
          restorationId: restorationId,
        );

  @override
  _SearchChoicesState<T> createState() => _SearchChoicesState<T>();
}

class _SearchChoicesState<T> extends FormFieldState<T> {
  List? selectedItems;
  PointerThisPlease<bool> displayMenu = PointerThisPlease<bool>(false);
  Function? updateParent;

  List<T> futureSelectedValues = [];

  Function? pop;

  @override
  SearchChoices<T> get widget => super.widget as SearchChoices<T>;

  void giveMeThePop(Function pop) {
    this.pop = pop;
    if (widget.giveMeThePop != null) {
      widget.giveMeThePop!(pop);
    }
  }

  TextStyle get _textStyle =>
      widget.style ??
      (_enabled && !(widget.readOnly)
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: _disabledIconColor)) ??
      TextStyle();
  bool get _enabled => widget.isEnabled;

  Color? get _enabledIconColor {
    if (widget.iconEnabledColor != null) {
      return widget.iconEnabledColor;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade700;
      case Brightness.dark:
        return Colors.white70;
    }
  }

  Color? get _disabledIconColor {
    if (widget.iconDisabledColor != null) {
      return widget.iconDisabledColor;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade400;
      case Brightness.dark:
        return Colors.white10;
    }
  }

  Color? get _iconColor {
    // These colors are not defined in the Material Design spec.
    return (_enabled && !(widget.readOnly)
        ? _enabledIconColor
        : _disabledIconColor);
  }

  bool get valid {
    return (validResult == null);
  }

  String? get validResult {
    if (widget.listValidator != null) {
      return (widget.listValidator!(selectedResult));
    }
    if (widget.validator != null) {
      return (widget.validator!(selectedResult));
    }
    return (null);
  }

  bool get hasSelection {
    if (widget.futureSearchFn != null) {
      return (futureSelectedValues.isNotEmpty);
    }
    return (selectedItems != null && ((selectedItems?.isNotEmpty) ?? true));
  }

  dynamic get selectedResult {
    if (widget.futureSearchFn != null) {
      if (widget.multipleSelection) {
        return (futureSelectedValues);
      }
      if (futureSelectedValues.isNotEmpty) {
        return (futureSelectedValues.first);
      }
      return (null);
    }
    return (widget.multipleSelection
        ? selectedItems
        : selectedItems?.isNotEmpty ?? false
            ? widget.items![selectedItems?.first ?? 0].value
            : null);
  }

  void updateSelectedItems({dynamic sel = const NotGiven()}) {
    if (widget.futureSearchFn != null) {
      return;
    }
    List<int>? updatedSelectedItems;
    if (widget.multipleSelection) {
      if (!(sel is NotGiven)) {
        updatedSelectedItems = sel as List<int>;
      } else {
        updatedSelectedItems = List<int>.from(widget.selectedItems);
      }
    } else {
      T? val = !(sel is NotGiven) ? sel as T? : widget.value;
      if (val != null) {
        int? i = indexFromValue(val);
        if (i != null && i != -1) {
          updatedSelectedItems = [i];
        }
      } else {
        updatedSelectedItems = null;
      }
      if (updatedSelectedItems == null) updatedSelectedItems = [];
    }
    selectedItems?.retainWhere((element) =>
        updatedSelectedItems?.any((selected) => selected == element) ?? false);
    updatedSelectedItems.forEach((selected) {
      if (!(selectedItems?.any((element) => selected == element) ?? true)) {
        selectedItems?.add(selected);
      }
    });
  }

  void updateSelectedValues({dynamic sel = const NotGiven()}) {
    if (widget.futureSearchFn == null) {
      return;
    }
    List<T>? updatedFutureSelectedValues;
    if (widget.multipleSelection) {
      if (!(sel is NotGiven)) {
        updatedFutureSelectedValues = sel as List<T>;
      } else {
        updatedFutureSelectedValues =
            List<T>.from(widget.futureSelectedValues!);
      }
    } else {
      T? val = !(sel is NotGiven) ? sel as T : widget.value;
      if (val != null) {
        updatedFutureSelectedValues = [val];
      }
      if (updatedFutureSelectedValues == null) updatedFutureSelectedValues = [];
    }
    futureSelectedValues.retainWhere((element) =>
        updatedFutureSelectedValues?.any((selected) => selected == element) ??
        false);
    updatedFutureSelectedValues.forEach((selected) {
      if (!(futureSelectedValues.any((element) => selected == element))) {
        futureSelectedValues.add(selected);
      }
    });
  }

  int? indexFromValue(T value) {
    assert(widget.futureSearchFn == null,
        "got a futureSearchFn with a call to indexFromValue");
    return (widget.items!.indexWhere((item) {
      return (item.value == value);
    }));
  }

  void sendSelection(dynamic selection, [BuildContext? onChangeContext]) {
    if (widget.validator != null || widget.listValidator != null) {
      try {
        didChange(selection);
      } catch (e, st) {
        if (!widget.multipleSelection) {
          debugPrint(
              "Warning: didChange call threw an error: ${e.toString()} ${st.toString()} You may want to reconsider the declared types otherwise the form validation may not consider this field properly.");
        } else {
          // We should try to make this work in multiple selection as well
          // see https://github.com/lcuis/search_choices/issues/97
          debugPrint(
              "Warning: SearchChoices multipleSelection doesn't fully support Form didChange call.");
        }
      }
    }
    try {
      widget.onChanged!();
    } catch (e) {
      try {
        widget.onChanged!(selection, onChangeContext);
      } catch (e) {
        try {
          widget.onChanged!(selection, pop);
        } catch (e) {
          try {
            widget.onChanged!(selection, onChangeContext, pop);
          } catch (e) {}
        }
      }
    }
  }

  @override
  void initState() {
    if (widget.setOpenDialog != null) {
      widget.setOpenDialog!(showDialogOrMenu);
    }
    if (widget.futureSearchFn != null) {
      futureSelectedValues = [];
      if (widget.futureSelectedValues != null) {
        futureSelectedValues.addAll(widget.futureSelectedValues!);
      }
      updateParent = (sel) {
        if (!(sel is NotGiven)) {
          sendSelection(sel, context);
          updateSelectedValues(sel: sel);
        }
      };
      updateSelectedValues();
    } else {
      selectedItems = [];
      selectedItems?.addAll(widget.selectedItems);
      updateParent = (sel) {
        if (!(sel is NotGiven)) {
          sendSelection(sel, context);
          updateSelectedItems(sel: sel);
        }
      };
      updateSelectedItems();
    }
    super.initState();
  }

  updateParentWithOptionalPop(
    value, [
    bool pop = false,
  ]) {
    updateParent!(value);
    if (pop && this.pop != null) {
      this.pop!();
    }
  }

  @override
  void didUpdateWidget(SearchChoices<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.futureSearchFn != null) {
      updateSelectedValues();
    } else {
      updateSelectedItems();
    }
  }

  Widget menuWidget({String searchTerms = ""}) {
    return StatefulBuilder(
        builder: (BuildContext menuContext, StateSetter setStateFromBuilder) {
      return (DropdownDialog(
        items: widget.items,
        hint: prepareWidget(widget.searchHint),
        isCaseSensitiveSearch: widget.isCaseSensitiveSearch,
        closeButton: widget.closeButton,
        keyboardType: widget.keyboardType,
        searchFn: widget.searchFn,
        multipleSelection: widget.multipleSelection,
        selectedItems: selectedItems,
        doneButton: widget.doneButton,
        displayItem: widget.displayItem,
        validator: widget.validator,
        dialogBox: widget.dialogBox,
        displayMenu: displayMenu,
        menuConstraints: widget.menuConstraints,
        menuBackgroundColor: widget.menuBackgroundColor,
        style: widget.style,
        iconEnabledColor: widget.iconEnabledColor,
        iconDisabledColor: widget.iconDisabledColor,
        callOnPop: () {
          giveMeThePop(() {});
          if (!widget.dialogBox &&
              widget.onChanged != null &&
              selectedResult != null) {
            sendSelection(selectedResult, menuContext);
          }
          setState(() {});
        },
        updateParent: (value) {
          updateParent!(value);
          setStateFromBuilder(() {});
        },
        rightToLeft: widget.rightToLeft,
        autofocus: widget.autofocus,
        initialSearchTerms: searchTerms,
        buildDropDownDialog: widget.buildDropDownDialog,
        dropDownDialogPadding: widget.dropDownDialogPadding,
        searchInputDecoration: widget.searchInputDecoration,
        itemsPerPage: widget.itemsPerPage,
        currentPage: widget.currentPage,
        customPaginationDisplay: widget.customPaginationDisplay,
        futureSearchFn: widget.futureSearchFn,
        futureSearchOrderOptions: widget.futureSearchOrderOptions,
        futureSearchFilterOptions: widget.futureSearchFilterOptions,
        futureSelectedValues: futureSelectedValues,
        emptyListWidget: widget.emptyListWidget,
        onTap: widget.onTap,
        futureSearchRetryButton: widget.futureSearchRetryButton,
        searchDelay: widget.searchDelay,
        giveMeThePop: giveMeThePop,
        clearSearchIcon: widget.clearSearchIcon,
        listValidator: widget.listValidator,
      ));
    });
  }

  Future<void> showDialogOrMenu(String searchTerms,
      {bool closeMenu = false}) async {
    if (widget.dialogBox) {
      if (widget.showDialogFn != null) {
        await widget.showDialogFn!(
          context,
          menuWidget,
          searchTerms,
        );
      } else {
        await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return (menuWidget(searchTerms: searchTerms));
            });
      }
      if (widget.onChanged != null && selectedResult != null) {
        try {
          sendSelection(selectedResult, context);
        } catch (e) {
          sendSelection(selectedResult);
        }
      }
    } else {
      displayMenu.value = !closeMenu;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildWidget(BuildContext context) {
    if (widget.setOpenDialog != null) {
      widget.setOpenDialog!(showDialogOrMenu);
    }
    final List<Widget> items =
        _enabled ? List<Widget>.from(widget.items ?? []) : <Widget>[];
    int? hintIndex;
    if (widget.hint != null ||
        (!_enabled &&
            prepareWidget(widget.disabledHint,
                    parameter: updateParentWithOptionalPop) !=
                null)) {
      final Widget? positionedHint = DropdownMenuItem<T>(
        child: (_enabled
                ? prepareWidget(widget.hint)
                : prepareWidget(widget.disabledHint,
                        parameter: updateParentWithOptionalPop) ??
                    prepareWidget(widget.hint)) ??
            SizedBox.shrink(),
      );
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: positionedHint,
          ignoringSemantics: false,
        ),
      ));
    }
    // Widget innerItemsWidget;
    // List<Widget> list = [];
    // if (widget.futureSearchFn == null) {
    //   selectedItems?.forEach((item) {
    //     if (!(item is NotGiven)) {
    //       list.add(widget.selectedValueWidgetFn != null
    //           ? widget.selectedValueWidgetFn!(widget.items![item].value)
    //           : items[item]);
    //     }
    //   });
    // } else {
    //   futureSelectedValues.forEach((element) {
    //     if (!(element is NotGiven)) {
    //       list.add(widget.selectedValueWidgetFn != null
    //           ? widget.selectedValueWidgetFn!(element)
    //           : element is String
    //               ? Text(element)
    //               : element);
    //     }
    //   });
    // }
    // if ((list.isEmpty && hintIndex != null) ||
    //     (list.length == 1 && list.first is NotGiven)) {
    //   innerItemsWidget = items[hintIndex ?? 0];
    // } else {
    //   innerItemsWidget = widget.selectedAggregateWidgetFn != null
    //       ? widget.selectedAggregateWidgetFn!(list)
    //       : Column(
    //           children: list,
    //         );
    // }
    Widget? clickable = InkWell(
      key: Key("clickableResultPlaceHolder"),
      //this key is used for running automated tests
      onTap: widget.readOnly || !_enabled
          ? null
          : () async {
              if (widget.onTap != null) {
                widget.onTap!();
              }
              await showDialogOrMenu("",
                  closeMenu: !widget.dialogBox && displayMenu.value);
            },
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            // color: Colors.amber,
            height: 40,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text("選択"),
          )
        ],
      ),
    );

    DefaultTextStyle result = DefaultTextStyle(
      style: _textStyle,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        // color: Colors.blue,
        // padding: padding.resolve(Directionality.of(context)),
        child: Row(
          children: <Widget>[
            widget.isExpanded
                ? Expanded(child: clickable ?? SizedBox.shrink())
                : clickable ?? SizedBox.shrink(),
          ],
        ),
      ),
    );

    final double bottom = 8.0;
    String? validatorOutput = validResult;
    Widget? labelOutput = prepareWidget(widget.label, parameter: selectedResult,
        stringToWidgetFunction: (string) {
      return (Text(string,
          textDirection:
              widget.rightToLeft ? TextDirection.rtl : TextDirection.ltr,
          style: TextStyle(color: Colors.blueAccent, fontSize: 13)));
    });
    Widget? fieldPresentation;
    EdgeInsets treatedPadding = widget.padding is EdgeInsets
        ? widget.padding
        : EdgeInsets.all(widget.padding is int
            ? widget.padding.toDouble()
            : widget.padding ?? 0);
    if (widget.fieldPresentationFn != null) {
      fieldPresentation = widget.fieldPresentationFn!(
        result,
        selectionIsValid: valid,
      );
    } else if (widget.fieldDecoration != null) {
      fieldPresentation = Padding(
        padding: treatedPadding,
        child: Container(
          decoration: widget.fieldDecoration,
          child: result,
        ),
      );
    } else {
      fieldPresentation = Stack(
        children: <Widget>[
          Padding(
            padding: treatedPadding,
            child: result,
          ),
          widget.underline is NotGiven
              ? SizedBox.shrink()
              : Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: bottom,
                  child: prepareWidget(widget.underline,
                          parameter: selectedResult) ??
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        valid ? Color(0xFFBDBDBD) : Colors.red,
                                    width: 0.0))),
                      ),
                ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        labelOutput ?? SizedBox.shrink(),
        fieldPresentation,
        ((validatorOutput == null)
            ? SizedBox.shrink()
            : Text(
                validatorOutput,
                textDirection:
                    widget.rightToLeft ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(color: Colors.red, fontSize: 13),
              )),
        displayMenu.value ? menuWidget() : SizedBox.shrink(),
      ],
    );
  }

  void clearSelection() {
    if (widget.futureSearchFn == null) {
      selectedItems?.clear();
    } else {
      futureSelectedValues.clear();
    }
    if (widget.onChanged != null) {
      sendSelection(selectedResult, context);
    }
    if (widget.onClear != null) {
      widget.onClear!();
    }
    setState(() {});
  }
}
