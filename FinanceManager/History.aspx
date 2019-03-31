<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="FinanceManager.History" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Verlauf</h1>
    <div>
        Historie der eingegebenen Symbole</div>
    <div>

        <div>

            <asp:Button ID="BT_Select" runat="server" OnClick="BT_Select_Click" Text="Auswahl" />
            <asp:Button ID="BT_Delete" runat="server" Text="Löschen" />
            <asp:Button ID="BT_Delete_All" runat="server" Text="Alles Löschen" />

        </div>





        <asp:GridView ID="GV_History" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="Verlauf" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="symbol" HeaderText="symbol" SortExpression="symbol" />
                <asp:BoundField DataField="begin" HeaderText="begin" SortExpression="begin" />
                <asp:BoundField DataField="end" HeaderText="end" SortExpression="end" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
        <asp:SqlDataSource ID="Verlauf" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnection %>" SelectCommand="SELECT [symbol], [begin], [end] FROM [history] WHERE (([username] = @username) AND ([modus] = @modus))">
            <SelectParameters>
                <asp:SessionParameter Name="username" SessionField="username" Type="String" />
                <asp:Parameter DefaultValue="0" Name="modus" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>

</asp:Content>
