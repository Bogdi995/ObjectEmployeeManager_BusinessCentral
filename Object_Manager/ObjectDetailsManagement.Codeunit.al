codeunit 50100 "Object Details Management"
{
    //  -------- Object Details --------> START
    procedure ConfirmCheckUpdateObjectDetails()
    var
        ConfirmMessageLbl: Label 'The objects are not updated, do you want to update them now?';
        ProgressLbl: Label 'The objects are being updated...';
        Progress: Dialog;
    begin
        if CheckUpdateObjectDetails() then
            if Confirm(ConfirmMessageLbl, true) then begin
                Progress.Open(ProgressLbl);
                UpdateObjectDetails();
                Progress.Close();
            end;
    end;

    procedure CheckUpdateObjectDetails(): Boolean
    var
        ObjectDetails: Record "Object Details";
    begin
        if CountAllObj() <> ObjectDetails.Count then
            exit(true);
        exit(false);
    end;

    local procedure CountAllObj(): Integer
    var
        AllObj: Record AllObj;
    begin
        AllObj.SetFilter("Object Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', AllObj."Object Type"::Table,
                         AllObj."Object Type"::"TableExtension", AllObj."Object Type"::Page,
                         AllObj."Object Type"::"PageExtension", AllObj."Object Type"::Report,
                         AllObj."Object Type"::Codeunit, AllObj."Object Type"::Enum,
                         AllObj."Object Type"::EnumExtension, AllObj."Object Type"::XMLport,
                         AllObj."Object Type"::Query, AllObj."Object Type"::MenuSuite);
        exit(AllObj.Count());
    end;

    procedure UpdateObjectDetails()
    var
        AllObj: Record AllObj;
    begin
        Update("Object Type"::Table, AllObj."Object Type"::Table);
        Update("Object Type"::"TableExtension", AllObj."Object Type"::"TableExtension");
        Update("Object Type"::Page, AllObj."Object Type"::Page);
        Update("Object Type"::"PageExtension", AllObj."Object Type"::"PageExtension");
        Update("Object Type"::Report, AllObj."Object Type"::Report);
        Update("Object Type"::Codeunit, AllObj."Object Type"::Codeunit);
        Update("Object Type"::Enum, AllObj."Object Type"::Enum);
        Update("Object Type"::EnumExtension, AllObj."Object Type"::EnumExtension);
        Update("Object Type"::XMLPort, AllObj."Object Type"::XMLport);
        Update("Object Type"::Query, AllObj."Object Type"::Query);
        Update("Object Type"::MenuSuite, AllObj."Object Type"::MenuSuite);
    end;

    local procedure Update(ObjectTypeObjectDetails: Enum "Object Type"; ObjectTypeAllObj: Integer)
    var
        AllObj: Record AllObj;
        ObjectDetails: Record "Object Details";
    begin
        AllObj.SetRange("Object Type", ObjectTypeAllObj);
        ObjectDetails.SetRange(ObjectType, ObjectTypeObjectDetails);

        if AllObj.FindSet() then
            if ObjectDetails.FindSet() then begin
                if AllObj.Count() > ObjectDetails.Count() then
                    repeat
                        ObjectDetails.SetRange(ObjectNo, AllObj."Object ID");
                        if not ObjectDetails.FindFirst() then
                            InsertNewRecord(AllObj, ObjectTypeObjectDetails);
                    until AllObj.Next() = 0
                else
                    if AllObj.Count() < ObjectDetails.Count() then
                        repeat
                            AllObj.SetRange("Object ID", ObjectDetails.ObjectNo);
                            if not AllObj.FindFirst() then
                                ObjectDetails.Delete(true);
                        until ObjectDetails.Next() = 0;
            end;
    end;

    local procedure InsertNewRecord(AllObj: Record AllObj; TypeOfObject: enum "Object Type")
    var
        ObjectDetails: Record "Object Details";
    begin
        ObjectDetails.Init();
        ObjectDetails.Validate(ObjectType, TypeOfObject);
        ObjectDetails.Validate(ObjectNo, AllObj."Object ID");
        ObjectDetails.Insert(true);
    end;

    procedure GetShowSubtype(ObjectType: Enum "Object Type"): Boolean
    begin
        if ObjectType = ObjectType::Codeunit then
            exit(true);
        exit(false);
    end;

    procedure GetShowNoUnused(No: Integer): Boolean
    begin
        if No <> 0 then
            exit(true);
        exit(false);
    end;
    //  -------- Object Details --------> END



    //  -------- Object Details Line (FIELDS and KEYS) --------> START
    // procedure ConfirmCheckUpdateTypeObjectDetailsLine(Type: Enum Types)
    // var
    //     Progress: Dialog;
    //     ConfirmMessage: Label 'The %1 are not updated, do you want to update them now?';
    //     ProgressText: Label 'The %1 are being updated...';
    // begin
    //     if CheckUpdateTypeObjectDetailsLine(Type) then
    //         if Confirm(StrSubstNo(ConfirmMessage, GetTypeText(Type)), true) then begin
    //             Progress.Open(StrSubstNo(ProgressText, GetTypeText(Type)));
    //             UpdateTypeObjectDetailsLine(Type);
    //             Progress.Close();
    //         end;
    // end;

    procedure CheckUpdateTypeObjectDetailsLine(ObjectDetails: Record "Object Details"; Type: Enum Types): Boolean
    var
        ObjectDetailsLine: Record "Object Details Line";
        RecRef: RecordRef;
        FRef: FieldRef;
        TableNoFRef: FieldRef;
    begin
        RecRef.Open(GetTypeTable(Type));
        TableNoFRef := RecRef.Field(1);
        TableNoFRef.SetRange(ObjectDetails.ObjectNo);
        FilterOutSystemValues(Type, FRef, RecRef);

        ObjectDetailsLine.SetRange(ObjectType, ObjectDetails.ObjectType);
        ObjectDetailsLine.SetRange(ObjectNo, ObjectDetails.ObjectNo);
        ObjectDetailsLine.SetRange(Type, Type);

        if not CheckTypeObjectDetailsLine(RecRef, ObjectDetailsLine) then
            exit(true);
        exit(false);
    end;

    local procedure CheckTypeObjectDetailsLine(RecRef: RecordRef; var ObjectDetailsLine: Record "Object Details Line"): Boolean
    begin
        if RecRef.Count() <> ObjectDetailsLine.Count() then
            exit(false);

        if RecRef.FindSet() then
            if ObjectDetailsLine.FindSet() then
                repeat
                    if Format(RecRef.Field(2)) <> Format(ObjectDetailsLine.ID) then
                        exit(false);
                    ObjectDetailsLine.Next();
                until RecRef.Next() = 0;
        exit(true);
    end;


    local procedure GetTypeText(Type: Enum Types): Text
    var
        FieldsLbl: Label 'fields';
        KeysLbl: Label 'keys';
    begin
        if Type = Types::Field then
            exit(FieldsLbl);
        exit(KeysLbl);
    end;

    procedure GetTypeTable(Type: Enum Types): Integer
    begin
        if Type = Type::Field then
            exit(Database::Field);
        exit(Database::"Key");
    end;

    procedure FilterOutSystemValues(Type: Enum Types; var FRef: FieldRef; Recref: RecordRef)
    var
        SystemKey: Label '$systemId';
        SystemFieldIDs: Integer;
    begin
        case Type of
            Types::Field:
                begin
                    SystemFieldIDs := 2000000000;
                    FRef := RecRef.Field(2);
                    FRef.SetFilter('<%1', SystemFieldIDs);
                end;
            Types::"Key":
                begin
                    FRef := RecRef.Field(4);
                    FRef.SetFilter('<>%1', SystemKey);
                end;
        end;
    end;

    procedure UpdateTypeObjectDetailsLine(Type: Enum Types; var NeedsUpdate: Boolean)
    var
        ObjectDetailsLine: Record "Object Details Line";
        RecRef: RecordRef;
        FRef: FieldRef;
        TableNoFRef: FieldRef;
        Filter: Text;
    begin
        Filter := GetObjectsWhereUpdateForTypeNeeded(Type);
        if Filter <> '' then begin
            NeedsUpdate := true;
            UpdateTypeObjectDetailsLine(Filter, Type);
        end;
    end;

    procedure UpdateTypeObjectDetailsLine(Filter: Text; Type: Enum Types)
    var
        ObjectDetailsLine: Record "Object Details Line";
        RecRef: RecordRef;
        FRef: FieldRef;
        TableNoFRef: FieldRef;
    begin
        if Filter <> '' then begin
            RecRef.Open(GetTypeTable(Type));
            TableNoFRef := RecRef.Field(1);
            FilterOutSystemValues(Type, FRef, RecRef);
            DeleteAllObjectDetailsLine(ObjectDetailsLine, Filter, Type);

            TableNoFRef.SetFilter(Filter);
            if RecRef.FindSet() then
                repeat
                    InsertObjectDetailsLine(RecRef, "Object Type"::Table, Type);
                until RecRef.Next() = 0;
        end;
    end;

    local procedure DeleteAllObjectDetailsLine(var ObjectDetailsLine: Record "Object Details Line"; Filter: Text; Type: Enum Types)
    begin
        ObjectDetailsLine.SetFilter(ObjectNo, Filter);
        ObjectDetailsLine.SetRange(Type, Type);
        if ObjectDetailsLine.FindSet() then
            ObjectDetailsLine.DeleteAll();
    end;

    local procedure GetObjectsWhereUpdateForTypeNeeded(Type: Enum Types): Text
    var
        AllObj: Record AllObj;
        ObjectDetailsLine: Record "Object Details Line";
        RecRef: RecordRef;
        FRef: FieldRef;
        TableNoFRef: FieldRef;
        Filter: Text;

    begin
        RecRef.Open(GetTypeTable(Type));
        TableNoFRef := RecRef.Field(1);
        FilterOutSystemValues(Type, FRef, RecRef);

        ObjectDetailsLine.SetRange(ObjectType, "Object Type"::Table);
        ObjectDetailsLine.SetRange(Type, Type);
        AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
        if AllObj.FindSet() then
            repeat
                TableNoFRef.SetRange(AllObj."Object ID");
                ObjectDetailsLine.SetRange(ObjectNo, AllObj."Object ID");
                if not CheckTypeObjectDetailsLine(RecRef, ObjectDetailsLine) then
                    Filter += Format(AllObj."Object ID") + '|';
            until AllObj.Next() = 0;
        Filter := DelChr(Filter, '>', '|');
        exit(Filter);
    end;

    procedure InsertObjectDetailsLine(RecRef: RecordRef; ObjectType: Enum "Object Type"; Type: Enum Types)
    var
        ObjectDetailsLine: Record "Object Details Line";
    begin
        ObjectDetailsLine.Init();
        ObjectDetailsLine.EntryNo := 0;
        ObjectDetailsLine.Validate(ObjectType, ObjectType);
        ObjectDetailsLine.Validate(ObjectNo, RecRef.Field(1).Value);
        ObjectDetailsLine.Validate(Type, Type);
        ObjectDetailsLine.Validate(ID, RecRef.Field(2).Value);
        ObjectDetailsLine.Insert(true);
    end;
    //  -------- Object Details Line (FIELDS and KEYS) --------> END



    //  -------- Object Details Line (METHODS and EVENTS) --------> START

    // Events/Methods -> Start
    [Scope('OnPrem')]
    procedure UpdateMethodsEventsObjectDetailsLine(ObjectDetails: Record "Object Details"; var NeedsUpdate: Boolean)
    var
        ObjectMetadataPage: Page "Object Metadata Page";
        Encoding: DotNet Encoding;
        StreamReader: DotNet StreamReader;
        ObjectALCode: DotNet String;
        InStr: InStream;
        GlobalMethods: List of [Text];
        LocalMethods: List of [Text];
        IntegrationEvents: List of [Text];
        BusinessEvents: List of [Text];
        ProcedureTxt: Label '    procedure';
        LocalProcedureTxt: Label '    local procedure';
        IntegrationEventTxt: Label '    [IntegrationEvent(%1, %2)]';
        BusinessEventTxt: Label '    [BusinessEvent(%1, %2)]';
    begin
        InStr := ObjectMetadataPage.GetUserALCodeInstream(ObjectDetails.ObjectTypeCopy, ObjectDetails.ObjectNo);
        ObjectALCode := StreamReader.StreamReader(InStr, Encoding.UTF8).ReadToEnd();

        IntegrationEvents := GetEvents(ObjectALCode, IntegrationEventTxt);
        BusinessEvents := GetEvents(ObjectALCode, BusinessEventTxt);
        RemoveEventsFromObject(ObjectALCode, IntegrationEvents, BusinessEvents);
        IntegrationEvents := GetFormattedEvents(IntegrationEvents);
        BusinessEvents := GetFormattedEvents(BusinessEvents);

        if ObjectALCode.IndexOf(ProcedureTxt) <> -1 then
            GlobalMethods := GetMethods(ObjectALCode, ProcedureTxt, false, '');
        if ObjectALCode.IndexOf(LocalProcedureTxt) <> -1 then
            LocalMethods := GetMethods(ObjectALCode, LocalProcedureTxt, false, '');

        if not CheckMethodsEvents(ObjectDetails, GlobalMethods, Types::"Global Method", true) then begin
            NeedsUpdate := true;
            UpdateMethodsEvents(ObjectDetails, GlobalMethods, Types::"Global Method", true);
        end;
        if not CheckMethodsEvents(ObjectDetails, LocalMethods, Types::"Local Method", true) then begin
            NeedsUpdate := true;
            UpdateMethodsEvents(ObjectDetails, LocalMethods, Types::"Local Method", true);
        end;
        if not CheckMethodsEvents(ObjectDetails, IntegrationEvents, Types::"Integration Event", false) then begin
            NeedsUpdate := true;
            UpdateMethodsEvents(ObjectDetails, IntegrationEvents, Types::"Integration Event", false);
        end;
        if not CheckMethodsEvents(ObjectDetails, BusinessEvents, Types::"Business Event", false) then begin
            NeedsUpdate := true;
            UpdateMethodsEvents(ObjectDetails, BusinessEvents, Types::"Business Event", false);
        end;
    end;

    [Scope('OnPrem')]
    local procedure GetEvents(ObjectALCode: DotNet String; EventTypeTxt: Text): List of [Text]
    var
        CopyObjectALCode: DotNet String;
        TypeEvents: List of [Text];
        TypeEvent: Text;
        ProcedureLbl: Label '    procedure';
        LocalProcedureLbl: Label '    local procedure';
    begin
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);

        repeat
            TypeEvent := GetEventParameters(CopyObjectALCode, EventTypeTxt);
            if TypeEvent <> '' then begin
                UpdateEvents(TypeEvents, CopyObjectALCode, TypeEvent, ProcedureLbl);
                UpdateEvents(TypeEvents, CopyObjectALCode, TypeEvent, LocalProcedureLbl);
            end;
        until TypeEvent = '';

        exit(TypeEvents);
    end;

    [Scope('OnPrem')]
    local procedure UpdateEvents(var TypeEvents: List of [Text]; ObjectALCode: DotNet String; EventType: Text; ProcedureType: Text)
    var
        TypeEventsAux: List of [Text];
        Member: Text;
    begin
        TypeEventsAux := GetEventsWithSpecificParameters(ObjectALCode, EventType, ProcedureType);

        if TypeEventsAux.Count() <> 0 then
            foreach Member in TypeEventsAux do begin
                TypeEvents.Add(Member);
                ObjectALCode := ObjectALCode.Remove(ObjectALCode.IndexOf(Member), StrLen(Member));
            end;
    end;

    [Scope('OnPrem')]
    local procedure RemoveEventsFromObject(ObjectALCode: DotNet String)
    var
        IntegrationEvents: List of [Text];
        BusinessEvents: List of [Text];
        IntegrationEventLbl: Label '    [IntegrationEvent(%1, %2)]';
        BusinessEventLbl: Label '    [BusinessEvent(%1, %2)]';
    begin
        IntegrationEvents := GetEvents(ObjectALCode, IntegrationEventLbl);
        BusinessEvents := GetEvents(ObjectALCode, BusinessEventLbl);
        RemoveEventsFromObject(ObjectALCode, IntegrationEvents, BusinessEvents);
    end;

    [Scope('OnPrem')]
    local procedure RemoveEventsFromObject(ObjectALCode: DotNet String; IntegrationEvents: List of [Text]; BusinessEvents: List of [Text])
    var
        Member: Text;
    begin
        foreach Member in IntegrationEvents do
            ObjectALCode := ObjectALCode.Remove(ObjectALCode.IndexOf(Member), StrLen(Member));
        foreach Member in BusinessEvents do
            ObjectALCode := ObjectALCode.Remove(ObjectALCode.IndexOf(Member), StrLen(Member));
    end;

    local procedure GetFormattedEvents(UnformattedEvents: List of [Text]): List of [Text]
    var
        FormattedEvents: List of [Text];
        Member: Text;
    begin
        foreach Member in UnformattedEvents do begin
            FormattedEvents.Add(FormatEvent(Member));
        end;

        exit(FormattedEvents);
    end;

    local procedure FormatEvent(UnformattedEvent: Text): Text
    var
        CRLF: Text[2];
        EventType: Text;
        ProcedureFromEvent: Text;
    begin
        CRLF[1] := 13;
        CRLF[2] := 10;
        EventType := UnformattedEvent.Substring(1, StrPos(UnformattedEvent, CRLF) - 1);
        ProcedureFromEvent := UnformattedEvent.Substring(StrLen(EventType) + 1);
        ProcedureFromEvent := DelChr(ProcedureFromEvent, '=', CRLF);
        ProcedureFromEvent := DelChr(ProcedureFromEvent, '<', ' ');
        EventType := DelChr(EventType, '<', ' ');
        exit(EventType + CRLF + ProcedureFromEvent);
    end;

    [Scope('OnPrem')]
    local procedure GetEventParameters(ObjectALCode: DotNet String; EventType: Text): Text
    var
        TrueLbl: Label 'true';
        FalseLbl: Label 'false';
    begin
        if ObjectALCode.IndexOf(StrSubstNo(EventType, TrueLbl, TrueLbl)) <> -1 then
            exit(StrSubstNo(EventType, TrueLbl, TrueLbl));
        if ObjectALCode.IndexOf(StrSubstNo(EventType, TrueLbl, FalseLbl)) <> -1 then
            exit(StrSubstNo(EventType, TrueLbl, FalseLbl));
        if ObjectALCode.IndexOf(StrSubstNo(EventType, FalseLbl, TrueLbl)) <> -1 then
            exit(StrSubstNo(EventType, FalseLbl, TrueLbl));
        if ObjectALCode.IndexOf(StrSubstNo(EventType, FalseLbl, FalseLbl)) <> -1 then
            exit(StrSubstNo(EventType, FalseLbl, FalseLbl));
    end;

    [Scope('OnPrem')]
    local procedure GetEventsWithSpecificParameters(ObjectALCode: DotNet String; EventType: Text; ProcedureTypeTxt: Text): List of [Text]
    var
        CopyObjectALCode: DotNet String;
        Index: Integer;
    begin
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);
        Index := CopyObjectALCode.IndexOf(EventType);
        CopyObjectALCode := CopyObjectALCode.Substring(Index + 4);
        if CopyObjectALCode.IndexOf(ProcedureTypeTxt) <> -1 then
            exit(GetMethods(CopyObjectALCode, ProcedureTypeTxt, true, EventType));
    end;

    [Scope('OnPrem')]
    local procedure GetMethods(ObjectALCode: DotNet String; MethodType: Text; IsEvent: Boolean; EventType: Text): List of [Text]
    var
        CopyObjectALCode: DotNet String;
        Substring: DotNet String;
        Methods: List of [Text];
        CRLF: Text[2];
        Method: Text;
        Index: Integer;
        SubstringIndex: Integer;
    begin
        CRLF[1] := 13;
        CRLF[2] := 10;
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);
        Index := CopyObjectALCode.IndexOf(MethodType);

        repeat
            Substring := CopyObjectALCode.Substring(Index);
            SubstringIndex := Substring.IndexOf('(');
            Method := Substring.Substring(0, SubstringIndex);

            if IsEvent then
                Methods.Add(EventType + CRLF + Method)
            else
                Methods.Add(Delchr(Method, '<', ' '));

            CopyObjectALCode := Substring.Substring(SubstringIndex);
            Index := CopyObjectALCode.IndexOf(MethodType);
        until Index = -1;

        exit(Methods);
    end;

    local procedure CheckMethodsEvents(ObjectDetails: Record "Object Details"; GivenList: List of [Text]; Type: Enum Types; IsUsed: Boolean): Boolean
    var
        ObjectDetailsLine: Record "Object Details Line";
    begin
        ObjectDetailsLine.SetRange(ObjectType, ObjectDetails.ObjectType);
        ObjectDetailsLine.SetRange(ObjectNo, ObjectDetails.ObjectNo);
        ObjectDetailsLine.SetRange(Type, Type);
        ObjectDetailsLine.SetRange(Used, IsUsed);

        if (ObjectDetailsLine.Count() = 0) and (GivenList.Count() = 0) then
            exit(true);

        if ObjectDetailsLine.FindSet() then
            repeat
                if not GivenList.Contains(ObjectDetailsLine.Name) then
                    exit(false);
            until ObjectDetailsLine.Next() = 0
        else
            exit(false);
        exit(true);
    end;

    local procedure UpdateMethodsEvents(ObjectDetails: Record "Object Details"; GivenList: List of [Text]; Type: Enum Types; IsUsed: Boolean)
    var
        ObjectDetailsLine: Record "Object Details Line";
        Member: Text;
    begin
        ObjectDetailsLine.SetRange(ObjectType, ObjectDetails.ObjectType);
        ObjectDetailsLine.SetRange(ObjectNo, ObjectDetails.ObjectNo);
        ObjectDetailsLine.SetRange(Type, Type);
        ObjectDetailsLine.SetRange(Used, IsUsed);
        if ObjectDetailsLine.FindSet() then
            ObjectDetailsLine.DeleteAll();

        foreach Member in GivenList do
            InsertObjectDetailsLine(ObjectDetails, Member, Type, IsUsed);
    end;

    local procedure InsertObjectDetailsLine(ObjectDetails: Record "Object Details"; Name: Text; Type: Enum Types; IsUsed: Boolean)
    var
        ObjectDetailsLine: Record "Object Details Line";
    begin
        ObjectDetailsLine.Init();
        ObjectDetailsLine.EntryNo := 0;
        ObjectDetailsLine.Validate(ObjectType, ObjectDetails.ObjectType);
        ObjectDetailsLine.Validate(ObjectNo, ObjectDetails.ObjectNo);
        ObjectDetailsLine.Validate(Type, Type);
        ObjectDetailsLine.Validate(Name, Name);
        ObjectDetailsLine.Validate(Used, IsUsed);
        ObjectDetailsLine.Insert(true);
    end;
    // Events/Methods -> End

    // Unused Global/Local Methods -> Start
    [Scope('OnPrem')]
    procedure UpdateUnusedMethods(ObjectDetails: Record "Object Details"; var NeedsUpdate: Boolean)
    var
        ObjectMetadataPage: Page "Object Metadata Page";
        Encoding: DotNet Encoding;
        StreamReader: DotNet StreamReader;
        ObjectALCode: DotNet String;
        InStr: InStream;
        UnusedGlobalMethods: List of [Text];
        UnusedLocalMethods: List of [Text];
        ProcedureLbl: Label '    procedure';
        LocalProcedureLbl: Label '    local procedure';
    begin
        InStr := ObjectMetadataPage.GetUserALCodeInstream(ObjectDetails.ObjectTypeCopy, ObjectDetails.ObjectNo);
        ObjectALCode := StreamReader.StreamReader(InStr, Encoding.UTF8).ReadToEnd();
        RemoveEventsFromObject(ObjectALCode);

        UnusedGlobalMethods := GetUnusedMethods(ObjectALCode, ProcedureLbl);
        UnusedGlobalMethods := GetUnusedMethods(ObjectALCode, LocalProcedureLbl);

        if UnusedGlobalMethods.Count() <> 0 then begin
            NeedsUpdate := true;
            InsertUnusedMethodsInObjectDetailsLine(ObjectDetails, UnusedGlobalMethods, true);
        end;
        if UnusedLocalMethods.Count() <> 0 then begin
            NeedsUpdate := true;
            InsertUnusedMethodsInObjectDetailsLine(ObjectDetails, UnusedLocalMethods, false);
        end;
    end;

    [Scope('OnPrem')]
    local procedure GetUnusedMethods(ObjectALCode: DotNet String; MethodType: Text): List of [Text]
    var
        Methods: List of [Text];
        UnusedMethods: List of [Text];
        ParametersTypes: List of [Text];
        Method: Text;
        MethodName: Text;
    begin
        if ObjectALCode.IndexOf(MethodType) <> -1 then
            Methods := GetMethods(ObjectALCode, MethodType, false, '');

        foreach Method in Methods do begin
            ParametersTypes := GetParametersTypesForMethod(ObjectALCode, Method);
            MethodName := GetMethodName(Method);
            if not CheckIfMethodIsUsedInObject(ObjectALCode, MethodName, ParametersTypes) then
                UnusedMethods.Add(Method);
        end;

        exit(UnusedMethods);
    end;

    [Scope('OnPrem')]
    local procedure GetParametersTypesForMethod(ObjectALCode: DotNet String; Method: Text): List of [Text]
    var
        CopyObjectALCode: DotNet String;
        MethodHeader: DotNet String;
        ParametersTypes: List of [Text];
        ParameterType: Text;
        Index: Integer;
        SubstringIndex: Integer;
        SubstringIndexEnd: Integer;
    begin
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);
        Index := CopyObjectALCode.IndexOf(Method);
        CopyObjectALCode := CopyObjectALCode.Substring(Index);
        SubstringIndex := CopyObjectALCode.IndexOf('(');
        SubstringIndexEnd := CopyObjectALCode.IndexOf(')');

        if SubstringIndexEnd - SubstringIndex <> 1 then begin
            MethodHeader := CopyObjectALCode.Substring(SubstringIndex, SubstringIndexEnd - SubstringIndex + 1);
            repeat
                Index := MethodHeader.IndexOf(';');
                if Index <> -1 then
                    ParameterType := MethodHeader.Substring(MethodHeader.IndexOf(':') + 2, MethodHeader.IndexOf(';') - MethodHeader.IndexOf(':') - 2)
                else
                    ParameterType := MethodHeader.Substring(MethodHeader.IndexOf(':') + 2, MethodHeader.IndexOf(')') - MethodHeader.IndexOf(':') - 2);
                ParametersTypes.Add(ParameterType);
                MethodHeader := MethodHeader.Substring(Index + 1);
            until Index = -1;
        end;

        exit(ParametersTypes);
    end;

    local procedure GetMethodName(Method: Text): Text
    var
        ProcedureLbl: Label 'procedure';
        LocalProcedureLbl: Label 'local procedure';
    begin
        if Method.Contains(ProcedureLbl) then
            exit(Method.Remove(1, StrLen(ProcedureLbl)));
        exit(Method.Remove(1, StrLen(LocalProcedureLbl)));
    end;

    [Scope('OnPrem')]
    local procedure CheckIfMethodIsUsedInObject(ObjectALCode: DotNet String; MethodName: Text; ParametersTypes: List of [Text]): Boolean
    var
        CopyObjectALCode: DotNet String;
        MethodCall: DotNet String;
        Index: Integer;
    begin
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);
        RemoveMethodsFromObject(CopyObjectALCode);
        MethodName := GetNewMethodName(MethodName, ParametersTypes.Count());
        Index := CopyObjectALCode.IndexOf(MethodName);

        // If method is not used in the object
        if Index = -1 then
            exit(false);

        // If method is used in object and doesn't have parameters
        if (Index <> -1) and (ParametersTypes.Count() = 0) then
            exit(true);

        // If method is used in the object and has one or more parameters
        if (Index <> -1) and (ParametersTypes.Count() <> 0) then begin
            CopyObjectALCode := CopyObjectALCode.Substring(Index);
            MethodCall := CopyObjectALCode.Substring(CopyObjectALCode.IndexOf('('), CopyObjectALCode.IndexOf(')') - CopyObjectALCode.IndexOf('(') + 1);
        end;

    end;

    local procedure GetNewMethodName(MethodName: Text; Count: Integer): Text
    begin
        if Count = 0 then
            exit(MethodName);
        exit(MethodName + '(');
    end;

    [Scope('OnPrem')]
    local procedure RemoveMethodsFromObject(ObjectALCode: DotNet String)
    var
        GlobalMethods: List of [Text];
        LocalMethods: List of [Text];
        ProcedureLbl: Label '    procedure';
        LocalProcedureLbl: Label '    local procedure';
    begin
        GlobalMethods := GetMethods(ObjectALCode, ProcedureLbl, false, '');
        LocalMethods := GetMethods(ObjectALCode, LocalProcedureLbl, false, '');
        RemoveMethodsFromObject(ObjectALCode, GlobalMethods, LocalMethods);
    end;

    [Scope('OnPrem')]
    local procedure RemoveMethodsFromObject(ObjectALCode: DotNet String; GlobalMethods: List of [Text]; LocalMethods: List of [Text])
    var
        Member: Text;
    begin
        foreach Member in GlobalMethods do
            ObjectALCode := ObjectALCode.Remove(ObjectALCode.IndexOf(Member), StrLen(Member));
        foreach Member in LocalMethods do
            ObjectALCode := ObjectALCode.Remove(ObjectALCode.IndexOf(Member), StrLen(Member));
    end;

    local procedure InsertUnusedMethodsInObjectDetailsLine(ObjectDetails: Record "Object Details"; UnusedMethods: List of [Text]; IsGlobal: Boolean)
    var
        Method: Text;
    begin
        foreach Method in UnusedMethods do
            InsertObjectDetailsLine(ObjectDetails, Method, GetType(IsGlobal), false);
    end;

    local procedure GetType(IsGlobal: Boolean): Enum Types
    begin
        if IsGlobal then
            exit(Types::"Global Method");
        exit(Types::"Local Method");
    end;
    // Unused Global/Local Methods -> End

    // Unused Parameters -> Start
    [Scope('OnPrem')]
    procedure UpdateUnusedParameters(ObjectDetails: Record "Object Details"; var NeedsUpdate: Boolean)
    var
        ObjectMetadataPage: Page "Object Metadata Page";
        Encoding: DotNet Encoding;
        StreamReader: DotNet StreamReader;
        ObjectALCode: DotNet String;
        InStr: InStream;
        UnusedParamsFromProcedures: List of [Text];
        UnusedParamsFromLocalProcedures: List of [Text];
        ProcedureLbl: Label '    procedure';
        LocalProcedureLbl: Label '    local procedure';
    begin
        InStr := ObjectMetadataPage.GetUserALCodeInstream(ObjectDetails.ObjectTypeCopy, ObjectDetails.ObjectNo);
        ObjectALCode := StreamReader.StreamReader(InStr, Encoding.UTF8).ReadToEnd();
        RemoveEventsFromObject(ObjectALCode);

        UnusedParamsFromProcedures := GetUnusedParameters(ObjectALCode, ProcedureLbl);
        UnusedParamsFromLocalProcedures := GetUnusedParameters(ObjectALCode, LocalProcedureLbl);

        if UnusedParamsFromProcedures.Count() <> 0 then begin
            NeedsUpdate := true;
            InsertUnusedParametersInObjectDetailsLine(ObjectDetails, UnusedParamsFromProcedures);
        end;
        if UnusedParamsFromLocalProcedures.Count() <> 0 then begin
            NeedsUpdate := true;
            InsertUnusedParametersInObjectDetailsLine(ObjectDetails, UnusedParamsFromLocalProcedures);
        end;
    end;

    [Scope('OnPrem')]
    procedure GetUnusedParameters(ObjectALCode: DotNet String; MethodType: Text): List of [Text]
    var
        CopyObjectALCode: DotNet String;
        MethodALCode: DotNet String;
        MethodHeader: DotNet String;
        MethodBody: DotNet String;
        UnusedParameters: List of [Text];
        ParametersList: List of [Text];
        Parameter: Text;
        EndLbl: Label '    end;';
        VarLbl: Label 'var ';
        Index: Integer;
        SubstringIndex: Integer;
        SubstringIndexEnd: Integer;
    begin
        CopyObjectALCode := CopyObjectALCode.Copy(ObjectALCode);
        Index := CopyObjectALCode.IndexOf(MethodType);

        repeat
            MethodHeader := CopyObjectALCode.Substring(Index + 4);
            CopyObjectALCode := CopyObjectALCode.Substring(Index + 4);
            SubstringIndex := MethodHeader.IndexOf('(');
            SubstringIndexEnd := MethodHeader.IndexOf(')');
            MethodBody := MethodHeader.Substring(SubstringIndexEnd + 2, MethodHeader.IndexOf(EndLbl) - (SubstringIndexEnd + 2) + StrLen(EndLbl));
            MethodHeader := MethodHeader.Substring(0, SubstringIndexEnd + 1);

            if SubstringIndexEnd - SubstringIndex <> 1 then
                while (SubstringIndex <> 0) do begin
                    MethodHeader := MethodHeader.Substring(SubstringIndex);
                    SubstringIndex := MethodHeader.IndexOf(':');
                    Parameter := MethodHeader.Substring(1, SubstringIndex - 1);
                    if Parameter.Contains(VarLbl) then
                        Parameter := Parameter.Remove(1, 4);
                    ParametersList.Add(Parameter);
                    SubstringIndex := MethodHeader.IndexOf(';') + 1;
                end;
            Index := CopyObjectALCode.IndexOf(MethodType);

            foreach Parameter in ParametersList do
                if not MethodBody.Contains(Parameter) then
                    UnusedParameters.Add(Parameter);
            ParametersList.RemoveRange(1, ParametersList.Count());
        until Index = -1;

        exit(UnusedParameters);
    end;

    local procedure InsertUnusedParametersInObjectDetailsLine(ObjectDetails: Record "Object Details"; UnusedParameters: List of [Text])
    var
        Parameter: Text;
    begin
        foreach Parameter in UnusedParameters do
            InsertObjectDetailsLine(ObjectDetails, Parameter, Types::Parameter, false);
    end;
    // Unused Parameters -> End

    //  -------- Object Details Line (METHODS and EVENTS) --------> END



    //  -------- Others -------> START
    procedure GetObjectTypeFromObjectDetails(ObjectDetails: Record "Object Details"): Integer
    var
        AllObj: Record AllObj;
    begin
        case ObjectDetails.ObjectType of
            "Object Type"::Table:
                exit(AllObj."Object Type"::Table);
            "Object Type"::"TableExtension":
                exit(AllObj."Object Type"::"TableExtension");
            "Object Type"::Page:
                exit(AllObj."Object Type"::Page);
            "Object Type"::"PageExtension":
                exit(AllObj."Object Type"::"PageExtension");
            "Object Type"::Report:
                exit(AllObj."Object Type"::Report);
            "Object Type"::Codeunit:
                exit(AllObj."Object Type"::Codeunit);
            "Object Type"::Enum:
                exit(AllObj."Object Type"::Enum);
            "Object Type"::EnumExtension:
                exit(AllObj."Object Type"::EnumExtension);
            "Object Type"::XMLPort:
                exit(AllObj."Object Type"::XMLport);
            "Object Type"::Query:
                exit(AllObj."Object Type"::Query);
            "Object Type"::MenuSuite:
                exit(AllObj."Object Type"::MenuSuite);
        end;
    end;
    //  -------- Others -------> END

}