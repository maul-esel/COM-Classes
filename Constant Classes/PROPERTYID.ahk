/*
class: PROPERTYID
an enumeration class that identifies UIAutomationElement properties.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/PROPERTYID)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ee684017, http://msdn.microsoft.com/en-us/library/windows/desktop/ee671200, http://msdn.microsoft.com/en-us/library/windows/desktop/ee671199)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows XP / Windows Server 2003 or higher
*/
class PROPERTYID
{
	/*
	Field: IsAnnotationPatternAvailable
	indicates whether the Annotation control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationAnnotationPattern interface from the element.
	*/
	static IsAnnotationPatternAvailable := 30118

	/*
	Field: IsDockPatternAvailable
	indicates whether the Dock control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationDockPattern interface from the element.
	*/
	static IsDockPatternAvailable := 30027

	/*
	Field: IsDragPatternAvailable
	indicates whether the Drag control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationDragPattern interface from the element.
	*/
	static IsDragPatternAvailable := 30137

	/*
	Field: IsDropTargetPatternAvailable
	indicates whether the DragTarget control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationDropTargetPattern interface from the element.
	*/
	static IsDropTargetPatternAvailable := 30141

	/*
	Field: IsExpandCollapsePatternAvailable
	indicates whether the ExpandCollapse control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationExpandCollapsePattern interface from the element.
	*/
	static IsExpandCollapsePatternAvailable := 30028

	/*
	Field: IsGridItemPatternAvailable
	indicates whether the GridItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationGridItemPattern interface from the element.
	*/
	static IsGridItemPatternAvailable := 30029

	/*
	Field: IsInvokePatternAvailable
	indicates whether the Invoke control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationInvokePattern interface from the element.
	*/
	static IsInvokePatternAvailable := 30031

	/*
	Field: IsItemContainerPatternAvailable
	indicates whether the ItemContainer control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationItemContainerPattern interface from the element.
	*/
	static IsItemContainerPatternAvailable := 30108

	/*
	Field: IsLegacyIAccessiblePatternAvailable
	indicates whether the LegacyIAccessible control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationLegacyIAccessiblePattern interface from the element.
	*/
	static IsLegacyIAccessiblePatternAvailable := 30090

	/*
	Field: IsMultipleViewPatternAvailable
	indicates whether the MultipleView control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationMultipleViewPattern interface from the element.
	*/
	static IsMultipleViewPatternAvailable := 30032

	/*
	Field: IsObjectModelPatternAvailable
	indicates whether the ObjectModel control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationObjectModelPattern interface from the element.
	*/
	static IsObjectModelPatternAvailable := 30112

	/*
	Field: IsRangeValuePatternAvailable
	indicates whether the RangeValue control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationRangeValuePattern interface from the element.
	*/
	static IsRangeValuePatternAvailable := 30033

	/*
	Field: IsScrollItemPatternAvailable
	indicates whether the ScrollItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationScrollItemPattern interface from the element.
	*/
	static IsScrollItemPatternAvailable := 30035

	/*
	Field: IsScrollPatternAvailable
	indicates whether the Scroll control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationScrollPattern interface from the element.
	*/
	static IsScrollPatternAvailable := 30034

	/*
	Field: IsSelectionItemPatternAvailable
	indicates whether the SelectionItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationSelectionItemPattern interface from the element.
	*/
	static IsSelectionItemPatternAvailable := 30036

	/*
	Field: IsSpreadsheetPatternAvailable
	indicates whether the SpreadsheetItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationSpreadsheetItemPattern interface from the element.
	*/
	static IsSpreadsheetPatternAvailable := 30128

	/*
	Field: IsStylesPatternAvailable
	indicates whether the Styles control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationStylesPattern interface from the element.
	*/
	static IsStylesPatternAvailable := 30127

	/*
	Field: IsSynchronizedInputPatternAvailable
	indicates whether the SynchronizedInput control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationSynchronizedInputPattern interface from the element.
	*/
	static IsSynchronizedInputPatternAvailable := 30110

	/*
	Field: IsTableItemPatternAvailable
	indicates whether the TableItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTableItemPattern interface from the element.
	*/
	static IsTableItemPatternAvailable := 30039

	/*
	Field: IsTablePatternAvailable
	indicates whether the Table control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTablePattern interface from the element.
	*/
	static IsTablePatternAvailable := 30038

	/*
	Field: IsTextChildPatternAvailable
	indicates whether the TextChild control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTextChildPattern interface from the element.
	*/
	static IsTextChildPatternAvailable := 30136

	/*
	Field: IsTextPatternAvailable
	indicates whether the Text control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTextPattern interface from the element.
	*/
	static IsTextPatternAvailable := 30040

	/*
	Field: IsTextPattern2Available
	indicates whether version two of the Text control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTextPattern2 interface from the element.
	*/
	static IsTextPattern2Available := 30119

	/*
	Field: IsTogglePatternAvailable
	indicates whether the Toggle control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTogglePattern interface from the element.
	*/
	static IsTogglePatternAvailable := 30041

	/*
	Field: IsTransformPatternAvailable
	indicates whether the Transform control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTransformPattern interface from the element.
	*/
	static IsTransformPatternAvailable := 30042

	/*
	Field: IsTransformPattern2Available
	indicates whether version two of the Transform control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationTransformPattern2 interface from the element.
	*/
	static IsTransformPattern2Available := 30134

	/*
	Field: IsValuePatternAvailable
	indicates whether the Value control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationValuePattern interface from the element.
	*/
	static IsValuePatternAvailable := 30043

	/*
	Field: IsVirtualizedItemPatternAvailable
	indicates whether the VirtualizedItem control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationVirtualizedItemPattern interface from the element.
	*/
	static IsVirtualizedItemPatternAvailable := 30109

	/*
	Field: IsWindowPatternAvailable
	indicates whether the Window control pattern is available for the automation element. If TRUE, a client can retrieve an IUIAutomationWindowPattern interface from the element.
	*/
	static IsWindowPatternAvailable := 30044

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 

	/*
	Field: 
	
	*/
	static  := 
}