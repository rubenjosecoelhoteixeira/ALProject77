codeunit 50014 "Post Invoices"
{
    Description = 'ARQNRSH';


    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        SalesPost: Codeunit "Sales-Post";
        PurchPost: Codeunit "Purch.-Post";
    begin
        With PurchaseHeader do begin
            SetRange("Document Type", "Document Type"::Invoice);
            if FindSet() then
                repeat
                    Receive := true;
                    Invoice := true;
                    PurchPost.Run(PurchaseHeader);
                until Next() = 0;
        end;

        With SalesHeader do begin
            SetRange("Document Type", "Document Type"::Invoice);
            if FindSet() then
                repeat
                    Ship := true;
                    Invoice := true;
                    SalesPost.Run(SalesHeader);
                until Next() = 0;
        end;
    end;
}