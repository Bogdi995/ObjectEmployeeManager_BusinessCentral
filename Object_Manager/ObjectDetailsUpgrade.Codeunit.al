codeunit 50102 "Object Details Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        Module: ModuleInfo;
        ObjectDetailsManagement: Codeunit "Object Details Management";
    begin
        NavApp.GetCurrentModuleInfo(Module);
        if Module.DataVersion.Major = 1 then begin
            if ObjectDetailsManagement.CheckUpdateObjectDetails() then
                ObjectDetailsManagement.UpdateObjectDetails();
            if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Types::Field) then
                ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Types::Field);
            if ObjectDetailsManagement.CheckUpdateTypeObjectDetailsLine(Types::"Key") then
                ObjectDetailsManagement.UpdateTypeObjectDetailsLine(Types::"Key");
        end;
    end;

}