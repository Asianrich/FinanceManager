<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="FinanceManager.History" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Verlauf</h1>
    <div>
        Historie der eingegebenen Symbole&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
    </div>
    <asp:Image ID="Image1" runat="server" Height="105px" Width="130px" ImageUrl="~/Picture/57143.png" />
    <div>

        <div>

            <asp:Button ID="BT_Select" runat="server" OnClick="BT_Select_Click" Text="Auswahl" />
            <asp:Button ID="BT_Delete" runat="server" Text="Löschen" OnClick="BT_Delete_Click" />
            <asp:Button ID="BT_Delete_All" runat="server" Text="Alles Löschen" OnClick="BT_Delete_All_Click" />

        </div>





        <asp:GridView ID="GV_History" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="Verlauf" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="symbol" HeaderText="symbol" SortExpression="symbol" />
                <asp:BoundField DataField="beginDate" HeaderText="beginDate" SortExpression="beginDate" />
                <asp:BoundField DataField="endDate" HeaderText="endDate" SortExpression="endDate" />
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
        <asp:SqlDataSource ID="Verlauf" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnectionDB %>" SelectCommand="SELECT [symbol], [beginDate], [endDate] FROM [history] WHERE (([modus] = @modus) AND ([username] = @username))">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="modus" Type="Int32" />
                <asp:SessionParameter Name="username" SessionField="Username" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>

</asp:Content>
