<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LookUpTable.aspx.cs" Inherits="FinanceManager.LookUpTable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>

        <asp:Button ID="BT_back" runat="server" OnClick="BT_back_Click" Text="Zurück" />
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="DataGridview" ForeColor="#333333" GridLines="None" AllowSorting="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="symbols" HeaderText="symbols" SortExpression="symbols" />
                <asp:BoundField DataField="openstock" HeaderText="openstock" SortExpression="openstock" />
                <asp:BoundField DataField="High" HeaderText="High" SortExpression="High" />
                <asp:BoundField DataField="Low" HeaderText="Low" SortExpression="Low" />
                <asp:BoundField DataField="Closestock" HeaderText="Closestock" SortExpression="Closestock" />
                <asp:BoundField DataField="Volume" HeaderText="Volume" SortExpression="Volume" />
                <asp:BoundField DataField="AdjustedClose" HeaderText="AdjustedClose" SortExpression="AdjustedClose" />
                <asp:BoundField DataField="DateTime" HeaderText="DateTime" SortExpression="DateTime" />
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
        <asp:SqlDataSource ID="DataGridview" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnection %>" SelectCommand="SELECT [symbols], [openstock], [High], [Low], [Closestock], [Volume], [AdjustedClose], [DateTime] FROM [stock]"></asp:SqlDataSource>

    </div>
</asp:Content>
