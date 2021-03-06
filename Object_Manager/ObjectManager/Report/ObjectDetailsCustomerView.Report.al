report 50100 "Object Details Customer View"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ObjectDetailsCustomerView.rdlc';

    Extensible = true;
    Caption = 'Object Details Customer View';
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Integer")
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));

            column(CurrUserID; Format(UserId))
            {
            }
            column(CurrDay; Format(Today))
            {
            }
            column(ReportID; CopyStr(CurrReport.ObjectId(false), 7))
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
        }

        dataitem(ObjectFields; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(FieldsTxt; FieldsTxt)
            {
            }
            column(FieldsCount; FieldsCount)
            {
            }
            column(FieldsURL; FieldsURL)
            {
            }
            column(Object_Type_Fields; "Object Type")
            {
            }
            column(ObjectNo_Fields; ObjectNo)
            {
            }
            column(Type_Fields; Type)
            {
            }
            column(ID_Fields; ID)
            {
            }
            column(Name_Fields; Name)
            {
            }
            column(TypeName_Fields; TypeName)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectFields.SetRange("Object Type", ObjType);
                ObjectFields.SetRange(ObjectNo, ObjNo);
                ObjectFields.SetRange(Type, ObjectFields.Type::Field);

                FieldsCount := ObjectFields.Count;
                FieldsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectFields, true);
            end;

            trigger OnAfterGetRecord()
            var
                Field: Record Field;
            begin
                if Field.Get(ObjectNo, ID) then begin
                    Name := Field.FieldName;
                    TypeName := Field."Type Name";
                end;
            end;
        }

        dataitem(ObjectKeys; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(KeysTxt; KeysTxt)
            {
            }
            column(KeysCount; KeysCount)
            {
            }
            column(KeysURL; KeysURL)
            {
            }
            column(Object_Type_Keys; "Object Type")
            {
            }
            column(ObjectNo_Keys; ObjectNo)
            {
            }
            column(Type_Keys; Type)
            {
            }
            column(ID_Keys; ID)
            {
            }
            column(Name_Keys; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectKeys.SetRange("Object Type", ObjType);
                ObjectKeys.SetRange(ObjectNo, ObjNo);
                ObjectKeys.SetRange(Type, ObjectKeys.Type::"Key");

                KeysCount := ObjectKeys.Count;
                KeysURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectKeys, true);
            end;

            trigger OnAfterGetRecord()
            var
                Keys: Record "Key";
            begin
                if Keys.Get(ObjectNo, ID) then
                    Name := Keys."Key";
            end;
        }

        dataitem(ObjectEvents; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(EventsTxt; EventsTxt)
            {
            }
            column(EventsCount; EventsCount)
            {
            }
            column(EventsURL; EventsURL)
            {
            }
            column(Object_Type_Events; "Object Type")
            {
            }
            column(ObjectNo_Events; ObjectNo)
            {
            }
            column(Type_Events; Type)
            {
            }
            column(Name_Events; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectEvents.SetRange("Object Type", ObjType);
                ObjectEvents.SetRange(ObjectNo, ObjNo);
                ObjectEvents.SetFilter(Type, '%1|%2', ObjectMethods.Type::"Business Event", ObjectMethods.Type::"Integration Event");

                EventsCount := ObjectEvents.Count;
                EventsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectEvents, true);
            end;
        }

        dataitem(ObjectMethods; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(MethodsTxt; MethodsTxt)
            {
            }
            column(MethodsCount; MethodsCount)
            {
            }
            column(MethodsURL; MethodsURL)
            {
            }
            column(Object_Type_Methods; "Object Type")
            {
            }
            column(ObjectNo_Methods; ObjectNo)
            {
            }
            column(Type_Methods; Type)
            {
            }
            column(Name_Methods; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectMethods.SetRange("Object Type", ObjType);
                ObjectMethods.SetRange(ObjectNo, ObjNo);
                ObjectMethods.SetFilter(Type, '%1|%2', ObjectMethods.Type::"Global Method", ObjectMethods.Type::"Local Method");

                MethodsCount := ObjectMethods.Count;
                MethodsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectMethods, true);
            end;
        }

        dataitem(ObjectUnusedMethods; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(UnusedMethodsTxt; UnusedMethodsTxt)
            {
            }
            column(UnusedMethodsCount; UnusedMethodsCount)
            {
            }
            column(UnusedMethodsURL; UnusedMethodsURL)
            {
            }
            column(Object_Type_UnusedMethods; "Object Type")
            {
            }
            column(ObjectNo_UnusedMethods; ObjectNo)
            {
            }
            column(Type_UnusedMethods; Type)
            {
            }
            column(Name_UnusedMethods; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectUnusedMethods.SetRange("Object Type", ObjType);
                ObjectUnusedMethods.SetRange(ObjectNo, ObjNo);
                ObjectUnusedMethods.SetFilter(Type, '%1|%2', ObjectUnusedMethods.Type::"Global Method", ObjectMethods.Type::"Local Method");
                ObjectUnusedMethods.SetRange(Used, false);

                UnusedMethodsCount := ObjectUnusedMethods.Count;
                UnusedMethodsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectUnusedMethods, true);
            end;
        }

        dataitem(ObjectUnusedReturnValues; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(UnusedReturnValuesTxt; UnusedReturnValuesTxt)
            {
            }
            column(UnusedReturnValuesCount; UnusedReturnValuesCount)
            {
            }
            column(UnusedReturnValuesURL; UnusedReturnValuesURL)
            {
            }
            column(Object_Type_UnusedReturnValues; "Object Type")
            {
            }
            column(ObjectNo_UnusedReturnValues; ObjectNo)
            {
            }
            column(Type_UnusedReturnValues; Type)
            {
            }
            column(Name_UnusedReturnValues; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectUnusedReturnValues.SetRange("Object Type", ObjType);
                ObjectUnusedReturnValues.SetRange(ObjectNo, ObjNo);
                ObjectUnusedReturnValues.SetRange(Type, ObjectUnusedReturnValues.Type::"Return Value");
                ObjectUnusedReturnValues.SetRange(Used, false);

                UnusedReturnValuesCount := ObjectUnusedReturnValues.Count;
                UnusedReturnValuesURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectUnusedReturnValues, true);
            end;
        }

        dataitem(ObjectUnusedParameters; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(UnusedParametersTxt; UnusedParametersTxt)
            {
            }
            column(UnusedParametersCount; UnusedParametersCount)
            {
            }
            column(UnusedParametersURL; UnusedParametersURL)
            {
            }
            column(Object_Type_UnusedParameters; "Object Type")
            {
            }
            column(ObjectNo_UnusedParameters; ObjectNo)
            {
            }
            column(Type_UnusedParameters; Type)
            {
            }
            column(Name_UnusedParameters; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectUnusedParameters.SetRange("Object Type", ObjType);
                ObjectUnusedParameters.SetRange(ObjectNo, ObjNo);
                ObjectUnusedParameters.SetRange(Type, ObjectUnusedParameters.Type::Parameter);
                ObjectUnusedParameters.SetRange(Used, false);

                UnusedParametersCount := ObjectUnusedParameters.Count;
                UnusedParametersURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectUnusedParameters, true);
            end;
        }

        dataitem(ObjectVariables; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(VariablesTxt; VariablesTxt)
            {
            }
            column(VariablesCount; VariablesCount)
            {
            }
            column(VariablesURL; VariablesURL)
            {
            }
            column(Object_Type_Variables; "Object Type")
            {
            }
            column(ObjectNo_Variables; ObjectNo)
            {
            }
            column(Type_Variables; Type)
            {
            }
            column(Name_Variables; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectVariables.SetRange("Object Type", ObjType);
                ObjectVariables.SetRange(ObjectNo, ObjNo);
                ObjectVariables.SetFilter(Type, '%1|%2', ObjectVariables.Type::"Global Variable", ObjectVariables.Type::"Local Variable");

                VariablesCount := ObjectVariables.Count;
                VariablesURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectVariables, true);
            end;
        }

        dataitem(ObjectUnusedVariables; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(UnusedVariablesTxt; UnusedVariablesTxt)
            {
            }
            column(UnusedVariablesCount; UnusedVariablesCount)
            {
            }
            column(UnusedVariablesURL; UnusedVariablesURL)
            {
            }
            column(Object_Type_UnusedVariables; "Object Type")
            {
            }
            column(ObjectNo_UnusedVariables; ObjectNo)
            {
            }
            column(Type_UnusedVariables; Type)
            {
            }
            column(Name_UnusedVariables; Name)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectUnusedVariables.SetRange("Object Type", ObjType);
                ObjectUnusedVariables.SetRange(ObjectNo, ObjNo);
                ObjectUnusedVariables.SetFilter(Type, '%1|%2', ObjectUnusedVariables.Type::"Global Variable", ObjectUnusedVariables.Type::"Local Variable");
                ObjectUnusedVariables.SetRange(Used, false);

                UnusedVariablesCount := ObjectUnusedVariables.Count;
                UnusedVariablesURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectUnusedVariables, true);
            end;
        }

        dataitem(ObjectRelations; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(RelationsTxt; RelationsTxt)
            {
            }
            column(RelationsCount; RelationsCount)
            {
            }
            column(RelationsURL; RelationsURL)
            {
            }
            column(Object_Type_Relations; "Object Type")
            {
            }
            column(ObjectNo_Relations; ObjectNo)
            {
            }
            column(Type_Relations; Type)
            {
            }
            column(ID_Relations; ID)
            {
            }
            column(Name_Relations; Name)
            {
            }
            column(TypeName_Relations; TypeName)
            {
            }

            trigger OnPreDataItem()
            begin
                ObjectRelations.SetRange("Object Type", ObjType);
                ObjectRelations.SetRange(ObjectNo, ObjNo);
                ObjectRelations.SetFilter(Type, '%1|%2', ObjectRelations.Type::"Relation (Internal)", ObjectRelations.Type::"Relation (External)");

                RelationsCount := ObjectRelations.Count;
                RelationsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", ObjectRelations, true);
            end;
        }

        dataitem(NoObjectsUsedIn; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(NoObjectsUsedInTxt; NoObjectsUsedInTxt)
            {
            }
            column(NoObjectsUsedInCount; NoObjectsUsedInCount)
            {
            }
            column(NoObjectsUsedInURL; NoObjectsUsedInURL)
            {
            }
            column(Object_Type_NoObjectsUsedIn; "Object Type")
            {
            }
            column(ObjectNo_NoObjectsUsedIn; ObjectNo)
            {
            }
            column(Type_NoObjectsUsedIn; Type)
            {
            }
            column(ID_NoObjectsUsedIn; ID)
            {
            }
            column(Name_NoObjectsUsedIn; Name)
            {
            }
            column(TypeName_NoObjectsUsedIn; TypeName)
            {
            }

            trigger OnPreDataItem()
            begin
                NoObjectsUsedIn.SetRange("Object Type", ObjType);
                NoObjectsUsedIn.SetRange(ObjectNo, ObjNo);
                NoObjectsUsedIn.SetRange(Type, NoObjectsUsedIn.Type::"Object (Internal)");

                NoObjectsUsedInCount := NoObjectsUsedIn.Count;
                NoObjectsUsedInURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", NoObjectsUsedIn, true);
            end;
        }

        dataitem(UsedInNoObjects; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(UsedInNoObjectsTxt; UsedInNoObjectsTxt)
            {
            }
            column(UsedInNoObjectsCount; UsedInNoObjectsCount)
            {
            }
            column(UsedInNoObjectsURL; UsedInNoObjectsURL)
            {
            }
            column(Object_Type_UsedInNoObjects; "Object Type")
            {
            }
            column(ObjectNo_UsedInNoObjectss; ObjectNo)
            {
            }
            column(Type_UsedInNoObjects; Type)
            {
            }
            column(ID_UsedInNoObjects; ID)
            {
            }
            column(Name_UsedInNoObjects; Name)
            {
            }
            column(TypeName_UsedInNoObjects; TypeName)
            {
            }

            trigger OnPreDataItem()
            begin
                UsedInNoObjects.SetRange("Object Type", ObjType);
                UsedInNoObjects.SetRange(ObjectNo, ObjNo);
                UsedInNoObjects.SetRange(Type, UsedInNoObjects.Type::"Object (External)");

                UsedInNoObjectsCount := UsedInNoObjects.Count;
                UsedInNoObjectsURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", UsedInNoObjects, true);
            end;
        }

        dataitem(NoOfTimesUsed; "Object Details Line")
        {
            DataItemTableView = sorting(EntryNo) order(ascending);

            column(NoTimesUsedTxt; NoTimesUsedTxt)
            {
            }
            column(NoTimesUsedCount; NoTimesUsedCount)
            {
            }
            column(NoTimesUsedURL; NoTimesUsedURL)
            {
            }
            column(Object_Type_NoOfTimesUsed; "Object Type")
            {
            }
            column(ObjectNo_NoOfTimesUsed; ObjectNo)
            {
            }
            column(Type_NoOfTimesUsed; Type)
            {
            }
            column(ID_NoOfTimesUsed; ID)
            {
            }
            column(Name_NoOfTimesUsed; Name)
            {
            }
            column(TypeName_NoOfTimesUsed; TypeName)
            {
            }
            column(NoTimesUsed; NoTimesUsed)
            {
            }

            trigger OnPreDataItem()
            begin
                NoOfTimesUsed.SetRange("Object Type", ObjType);
                NoOfTimesUsed.SetRange(ObjectNo, ObjNo);
                NoOfTimesUsed.SetRange(Type, NoOfTimesUsed.Type::"Object (Used)");

                if NoOfTimesUsed.FindSet() then
                    repeat
                        NoTimesUsedCount += NoOfTimesUsed.NoTimesUsed;
                    until NoOfTimesUsed.Next() = 0;
                NoTimesUsedURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Object Details Line List", NoOfTimesUsed, true);
            end;
        }
    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Object Type"; ObjType)
                    {
                        Caption = 'Object Type';
                        ApplicationArea = All;
                    }
                    field(ObjectNo; ObjNo)
                    {
                        Caption = 'Object No.';
                        TableRelation = "Object Details".ObjectNo;
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
        DetailsLbl = 'Details';
        CountLbl = 'Count';
        ObjectTypeLbl = 'Object Type';
        ObjectNoLbl = 'Object No.';
        TypeLbl = 'Type';
        IDLbl = 'ID';
        NameLbl = 'Name';
        TypeNameLbl = 'Type Name';
        NoTimesUsedLbl = 'No. Times Used';
    }

    trigger OnPreReport()
    var
        ObjectDetails: Record "Object Details";
    begin
        if ObjectDetails.Get(ObjType, ObjNo) then begin
            ObjectDetails.CalcFields(Name);
            ReportName := StrSubstNo(ReportNameTxt, ObjType, ObjNo, ObjectDetails.Name);
        end;
    end;

    var
        ObjType: Enum "Object Type";
        ReportName: Text;
        FieldsURL: Text;
        KeysURL: Text;
        EventsURL: Text;
        MethodsURL: Text;
        UnusedMethodsURL: Text;
        UnusedReturnValuesURL: Text;
        UnusedParametersURL: Text;
        VariablesURL: Text;
        UnusedVariablesURL: Text;
        RelationsURL: Text;
        NoObjectsUsedInURL: Text;
        UsedInNoObjectsURL: Text;
        NoTimesUsedURL: Text;
        ReportNameTxt: Label 'Customer view: %1 %2 "%3"';
        FieldsTxt: Label 'Fields';
        KeysTxt: Label 'Keys';
        EventsTxt: Label 'Events';
        MethodsTxt: Label 'Methods';
        UnusedMethodsTxt: Label 'Unused Methods';
        UnusedReturnValuesTxt: Label 'Unused Return Values';
        UnusedParametersTxt: Label 'Unused Parameters';
        VariablesTxt: Label 'Variables';
        UnusedVariablesTxt: Label 'Unused Variables';
        RelationsTxt: Label 'Relations';
        NoObjectsUsedInTxt: Label 'No of Objects Used In';
        UsedInNoObjectsTxt: Label 'Used In No of Objects';
        NoTimesUsedTxt: Label 'No of times used';
        ObjNo: Integer;
        FieldsCount: Integer;
        KeysCount: Integer;
        EventsCount: Integer;
        MethodsCount: Integer;
        UnusedMethodsCount: Integer;
        UnusedReturnValuesCount: Integer;
        UnusedParametersCount: Integer;
        VariablesCount: Integer;
        UnusedVariablesCount: Integer;
        RelationsCount: Integer;
        NoObjectsUsedInCount: Integer;
        UsedInNoObjectsCount: Integer;
        NoTimesUsedCount: Integer;
}