page 50101 "Object Details Card"
{
    PageType = Card;
    SourceTable = "Object Details";
    Caption = 'Object Details Card';
    ApplicationArea = All;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report,Update';

    layout
    {
        area(Content)
        {
            group(Details)
            {
                Caption = 'Details';
                field(ObjectType; Rec."Object Type")
                {
                    ToolTip = 'Specifies the type of the object.';
                    ApplicationArea = All;
                }
                field(ObjectNo; Rec.ObjectNo)
                {
                    ToolTip = 'Specifies the number of the object.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the object.';
                    ApplicationArea = All;
                }
                field(Caption; Rec.Caption)
                {
                    ToolTip = 'Specifies the caption of the object.';
                    ApplicationArea = All;
                }
                group(Subtype)
                {
                    ShowCaption = false;
                    Visible = ShowSubtypeSingleInstance;
                    field(SingleInstance; Rec.SingleInstance)
                    {
                        ToolTip = 'This field is visible only when the type of the object is Codeunit.';
                        ApplicationArea = All;
                    }
                    field(ObjectSubtype; Rec.ObjectSubtype)
                    {
                        ToolTip = 'This field is visible only when the type of the object is Codeunit.';
                        ApplicationArea = All;
                    }
                }
                group(FieldsKeys)
                {
                    ShowCaption = false;
                    Visible = ShowFieldsKeys;

                    field(PrimaryKey; Rec.PrimaryKey)
                    {
                        ToolTip = 'Specifies the primary key of the object.';
                        ApplicationArea = All;
                    }
                    field(NoKeys; Rec.NoKeys)
                    {
                        ToolTip = 'Specifies the number of keys the object has.';
                        ApplicationArea = All;
                    }
                    field(NoFields; Rec.NoFields)
                    {
                        ToolTip = 'Specifies the number of fields the object has.';
                        ApplicationArea = All;
                    }
                }
                group(Relations)
                {
                    group(RelationVisibility)
                    {
                        ShowCaption = false;
                        Visible = ShowRelations;

                        field(RelationsFrom; Rec.RelationsFrom)
                        {
                            ToolTip = 'Specifies the number of relations the object has from other objects.';
                            ApplicationArea = All;
                        }
                        field(RelationsTo; Rec.RelationsTo)
                        {
                            ToolTip = 'Specifies the number of relations the object has to other objects.';
                            ApplicationArea = All;
                        }
                    }

                    field(NoObjectsUsedIn; Rec.NoObjectsUsedIn)
                    {
                        ToolTip = 'Specifies the number of objects used in the object.';
                        ApplicationArea = All;
                    }
                    field(UsedInNoObjects; Rec.UsedInNoObjects)
                    {
                        ToolTip = 'Specifies the number of objects the object is used in.';
                        ApplicationArea = All;
                    }
                    field(NoTimesUsed; Rec.NoTimesUsed)
                    {
                        ToolTip = 'Specifies the number of times the object was used.';
                        ApplicationArea = All;
                    }
                }
                group(MethodsEvents)
                {
                    Caption = 'Methods and Events';
                    ShowCaption = true;

                    field(NoIntegrationEvents; Rec.NoIntegrationEvents)
                    {
                        ToolTip = 'Specifies the number of integration events.';
                        ApplicationArea = All;
                    }
                    field(NoBusinessEvents; Rec.NoBusinessEvents)
                    {
                        ToolTip = 'Specifies the number of business events.';
                        ApplicationArea = All;
                    }
                    field(NoGlobalMethods; Rec.NoGlobalMethods)
                    {
                        ToolTip = 'Specifies the number of global methods.';
                        ApplicationArea = All;
                    }
                    group(UnusedGlobalMethods)
                    {
                        ShowCaption = false;
                        Visible = ShowNoUnusedGlobalMethods;
                        field(NoUnusedGlobalMethods; Rec.NoUnusedGlobalMethods)
                        {
                            ToolTip = 'This field is visible only if the number of unused global methods is different than 0.';
                            ApplicationArea = All;
                        }
                    }
                    field(NoLocalMethods; Rec.NoLocalMethods)
                    {
                        ToolTip = 'Specifies the number of local methods.';
                        ApplicationArea = All;
                    }
                    group(UnusedLocalMethods)
                    {
                        ShowCaption = false;
                        Visible = ShowNoUnusedLocalMethods;
                        field(NoUnusedLocalMethods; Rec.NoUnusedLocalMethods)
                        {
                            ToolTip = 'This field is visible only if the number of unused local methods is different than 0.';
                            ApplicationArea = All;
                        }
                    }
                    field(NoUnusedParameters; Rec.NoUnusedParameters)
                    {
                        ToolTip = 'Specifies the number of unused parameters.';
                        ApplicationArea = All;
                    }
                    field(NoUnusedReturnValues; Rec.NoUnusedReturnValues)
                    {
                        ToolTip = 'Specifies the number of unused return values.';
                        ApplicationArea = All;
                    }
                }
                group(Variables)
                {
                    Caption = 'Variables';
                    ShowCaption = true;

                    field(NoTotalVariables; Rec.NoTotalVariables)
                    {
                        ToolTip = 'Specifies the total number of variables.';
                        ApplicationArea = All;
                    }
                    group(UnusedTotalVariables)
                    {
                        ShowCaption = false;
                        Visible = ShowNoUnusedTotalVariables;
                        field(NoUnusedTotalVariables; Rec.NoUnusedTotalVariables)
                        {
                            ToolTip = 'This field is visible only if the total number of variables is different than 0.';
                            ApplicationArea = All;
                        }
                    }
                    field(NoGlobalVariables; Rec.NoGlobalVariables)
                    {
                        ToolTip = 'Specifies the number of global variables.';
                        ApplicationArea = All;
                    }
                    group(UnusedGlobalVariables)
                    {
                        ShowCaption = false;
                        Visible = ShowNoUnusedGlobalVariables;
                        field(NoUnusedGlobalVariables; Rec.NoUnusedGlobalVariables)
                        {
                            ToolTip = 'This field is visible only if the number of global variables is different than 0.';
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Lines)
            {
                Caption = 'Lines';
                part("Object Details Subpage"; "Object Details Subpage")
                {
                    SubPageLink = "Object Type" = field("Object Type"), ObjectNo = field(ObjectNo);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateObjects)
            {
                Caption = 'Update Objects';
                ApplicationArea = All;
                Image = UpdateDescription;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateObjectsLbl: Label 'Do you want to update the objects?';
                    AlreadyUpdatedLbl: Label 'Objects already updated!';
                    SuccessfullyUpdatedLbl: Label 'Objects successfully updated!';
                    NeedsUpdate: array[4] of Boolean;
                begin
                    if Confirm(UpdateObjectsLbl, true) then begin
                        if ObjectDetailsManagement.CheckUpdateObjectDetails() then begin
                            ObjectDetailsManagement.UpdateObjectDetails();
                            NeedsUpdate[1] := true;
                        end;
                        Message(GetMessageForUser(NeedsUpdate, AlreadyUpdatedLbl, SuccessfullyUpdatedLbl));
                    end;
                end;
            }
            action(UpdateDetails)
            {
                Caption = 'Update Details';
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateDetailsLbl: Label 'Do you want to update the details for: %1 %2 - "%3"?';
                    SuccessfullyUpdatedLbl: Label 'Details successfully updated!';
                    AlreadyUpdatedLbl: Label 'Details already updated!';
                    UpdatingMethodsEventsLbl: Label 'The methods and the events are being updated...';
                    UpdatingRelationsLbl: Label 'The relations are being updated...';
                    UpdateUsedInNoOfObjectsLbl: Label 'The number of times the object is used in other objects is being updated...';
                    Progress: Dialog;
                    NeedsUpdate: array[12] of Boolean;
                    Index: Integer;
                begin
                    if Confirm(StrSubstNo(UpdateDetailsLbl, Rec."Object Type", Rec.ObjectNo, Rec.Name), true) then begin
                        if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Rec, Types::Field) then begin
                            ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Format(Rec.ObjectNo), Types::Field);
                            NeedsUpdate[5] := true;
                        end;
                        if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Rec, Types::"Key") then begin
                            ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Format(Rec.ObjectNo), Types::"Key");
                            NeedsUpdate[6] := true;
                        end;

                        Progress.Open(UpdatingMethodsEventsLbl);
                        ObjectDetailsManagement.UpdateMethodsEvents(Rec, NeedsUpdate, true);
                        Progress.Close();

                        ObjectDetailsManagement.UpdateVariables(Rec, NeedsUpdate[7]);
                        ObjectDetailsManagement.UpdateUnusedVariables(Rec, NeedsUpdate[8]);

                        if Rec."Object Type" = Rec."Object Type"::Table then begin
                            Progress.Open(UpdatingRelationsLbl);
                            ObjectDetailsManagement.UpdateRelations(Rec, NeedsUpdate[9], Types::"Relation (External)");
                            ObjectDetailsManagement.UpdateRelations(Rec, NeedsUpdate[10], Types::"Relation (Internal)");
                            Progress.Close();
                        end;

                        ObjectDetailsManagement.UpdateNoOfObjectsUsedIn(Rec, NeedsUpdate[11]);
                        Progress.Open(UpdateUsedInNoOfObjectsLbl);
                        ObjectDetailsManagement.UpdateUsedInNoOfObjects(Rec, NeedsUpdate[12]);
                        Progress.Close();
                        ObjectDetailsManagement.UpdateNoTimesUsed(Rec);

                        for Index := 1 to 12 do
                            if NeedsUpdate[Index] then begin
                                Message(SuccessfullyUpdatedLbl);
                                exit;
                            end;
                        Message(AlreadyUpdatedLbl);
                    end;
                end;
            }
            action(UpdateFieldsKeys)
            {
                Caption = 'Update Fields and Keys';
                ApplicationArea = All;
                Image = UpdateXML;
                Enabled = IsEnabled;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateFieldsKeysLbl: Label 'Do you want to update the fields and keys for: %1 %2 - "%3"?';
                    AlreadyUpdatedLbl: Label 'Fields and keys already updated!';
                    SuccessfullyUpdatedLbl: Label 'Fields and keys successfully updated!';
                    NeedsUpdate: array[4] of Boolean;
                begin
                    if Confirm(StrSubstNo(UpdateFieldsKeysLbl, Rec."Object Type", Rec.ObjectNo, Rec.Name), true) then begin
                        if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Rec, Types::Field) then begin
                            ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Format(Rec.ObjectNo), Types::Field);
                            NeedsUpdate[1] := true;
                        end;
                        if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Rec, Types::"Key") then begin
                            ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Format(Rec.ObjectNo), Types::"Key");
                            NeedsUpdate[2] := true;
                        end;
                        Message(GetMessageForUser(NeedsUpdate, AlreadyUpdatedLbl, SuccessfullyUpdatedLbl));
                    end;
                end;
            }
            action(UpdateMethodsEvents)
            {
                Caption = 'Update Methods and Events';
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateMethodsEventsLbl: Label 'Do you want to update the methods and events for: %1 %2 - "%3"?';
                    AlreadyUpdatedLbl: Label 'Methods and events already updated!';
                    SuccessfullyUpdatedLbl: Label 'Methods and events successfully updated!';
                    UpdatingMethodsEventsLbl: Label 'The methods and the events are being updated...';
                    Progress: Dialog;
                    NeedsUpdate: array[4] of Boolean;
                begin
                    if Confirm(StrSubstNo(UpdateMethodsEventsLbl, Rec."Object Type", Rec.ObjectNo, Rec.Name), true) then begin
                        Progress.Open(UpdatingMethodsEventsLbl);
                        ObjectDetailsManagement.UpdateMethodsEvents(Rec, NeedsUpdate, true);
                        Progress.Close();
                        Message(GetMessageForUser(NeedsUpdate, AlreadyUpdatedLbl, SuccessfullyUpdatedLbl));
                    end;
                end;
            }

            action(UpdateVariables)
            {
                Caption = 'Update Variables';
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateVariablesLbl: Label 'Do you want to update the variables for: %1 %2 - "%3"?';
                    AlreadyUpdatedLbl: Label 'Variables already updated!';
                    SuccessfullyUpdatedLbl: Label 'Variables successfully updated!';
                    NeedsUpdate: array[4] of Boolean;
                begin
                    if Confirm(StrSubstNo(UpdateVariablesLbl, Rec."Object Type", Rec.ObjectNo, Rec.Name), true) then begin
                        ObjectDetailsManagement.UpdateVariables(Rec, NeedsUpdate[1]);
                        ObjectDetailsManagement.UpdateUnusedVariables(Rec, NeedsUpdate[2]);
                        Message(GetMessageForUser(NeedsUpdate, AlreadyUpdatedLbl, SuccessfullyUpdatedLbl));
                    end;
                end;
            }

            action(UpdateRelations)
            {
                Caption = 'Update Relations';
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ObjectDetailsManagement: Codeunit "Object Details Management";
                    UpdateRelationsLbl: Label 'Do you want to update the relations for: %1 %2 - "%3"?';
                    AlreadyUpdatedLbl: Label 'Relations already updated!';
                    SuccessfullyUpdatedLbl: Label 'Relations successfully updated!';
                    UpdatingRelationsLbl: Label 'The relations are being updated...';
                    UpdateUsedInNoOfObjectsLbl: Label 'The number of times the object is used in other objects is being updated...';
                    Progress: Dialog;
                    NeedsUpdate: array[4] of Boolean;
                begin
                    if Confirm(StrSubstNo(UpdateRelationsLbl, Rec."Object Type", Rec.ObjectNo, Rec.Name), true) then begin
                        if Rec."Object Type" = Rec."Object Type"::Table then begin
                            Progress.Open(UpdatingRelationsLbl);
                            ObjectDetailsManagement.UpdateRelations(Rec, NeedsUpdate[1], Types::"Relation (External)");
                            ObjectDetailsManagement.UpdateRelations(Rec, NeedsUpdate[2], Types::"Relation (Internal)");
                            Progress.Close();
                        end;

                        ObjectDetailsManagement.UpdateNoOfObjectsUsedIn(Rec, NeedsUpdate[3]);
                        Progress.Open(UpdateUsedInNoOfObjectsLbl);
                        ObjectDetailsManagement.UpdateUsedInNoOfObjects(Rec, NeedsUpdate[4]);
                        Progress.Close();
                        ObjectDetailsManagement.UpdateNoTimesUsed(Rec);
                        Message(GetMessageForUser(NeedsUpdate, AlreadyUpdatedLbl, SuccessfullyUpdatedLbl));
                    end;
                end;
            }
        }

        area(Reporting)
        {
            action(CustomerView)
            {
                Caption = 'Customer view';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    XmlParameters: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name="Object Details Customer View" id="50100"><Options><Field name="ObjType">%1</Field><Field name="ObjNo">%2</Field></Options><DataItems><DataItem name="Header">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectFields">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectKeys">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectEvents">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectMethods">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectUnusedMethods">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectUnusedReturnValues">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectUnusedParameters">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectVariables">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectUnusedVariables">VERSION(1) SORTING(Field1)</DataItem><DataItem name="ObjectRelations">VERSION(1) SORTING(Field1)</DataItem><DataItem name="NoObjectsUsedIn">VERSION(1) SORTING(Field1)</DataItem><DataItem name="UsedInNoObjects">VERSION(1) SORTING(Field1)</DataItem><DataItem name="NoOfTimesUsed">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
                begin
                    Report.Execute(Report::"Object Details Customer View", StrSubstNo(XmlParameters, Rec."Object Type".AsInteger(), Rec.ObjectNo));
                end;
            }
        }
    }

    var
        [InDataSet]
        ShowFieldsKeys, ShowSubtypeSingleInstance, ShowNoUnusedTotalVariables, ShowNoUnusedGlobalVariables, ShowNoUnusedGlobalMethods, ShowNoUnusedLocalMethods, ShowRelations : Boolean;
        [InDataSet]
        IsEnabled: Boolean;

    trigger OnOpenPage()
    var
        ObjectDetailsManagement: Codeunit "Object Details Management";
    begin
        ObjectDetailsManagement.ConfirmCheckUpdateObjectDetails();
    end;

    trigger OnAfterGetRecord()
    var
        ObjectDetailsManagement: Codeunit "Object Details Management";
    begin
        ShowFieldsKeys := (Rec."Object Type" = Rec."Object Type"::Table);
        ShowSubtypeSingleInstance := (Rec."Object Type" = Rec."Object Type"::Codeunit);
        ShowRelations := (Rec."Object Type" = Rec."Object Type"::Table);
        ShowNoUnusedGlobalMethods := (Rec.NoGlobalMethods <> 0);
        ShowNoUnusedLocalMethods := (Rec.NoLocalMethods <> 0);
        ShowNoUnusedTotalVariables := (Rec.NoTotalVariables <> 0);
        ShowNoUnusedGlobalVariables := (Rec.NoGlobalVariables <> 0);
        IsEnabled := (Rec."Object Type" in [Rec."Object Type"::Table, Rec."Object Type"::"TableExtension"]);
        Rec.NoTimesUsed := ObjectDetailsManagement.GetNoTimesUsed(Rec);
    end;

    local procedure IsAlreadyUpdated(NeedsUpdate: array[4] of Boolean): Boolean
    var
        Index: Integer;
    begin
        for Index := 1 to 4 do
            if NeedsUpdate[Index] then
                exit(false);
        exit(true);
    end;

    local procedure GetMessageForUser(NeedsUpdate: array[4] of Boolean; AlreadyUpdated: Text; SuccessfullyUpdated: Text): Text
    begin
        if IsAlreadyUpdated(NeedsUpdate) then
            exit(AlreadyUpdated);
        exit(SuccessfullyUpdated);
    end;

}