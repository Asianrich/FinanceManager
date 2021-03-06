﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Compare.aspx.cs" Inherits="FinanceManager.Compare" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Aktienvergleich</h1>
    <div>
        <p>
            Symbol: Mehrere Symbole können eingegeben mit einem Trenner(Semicolon, Komma, Leerzeichen)
        </p>
        <p>
            Beispiel: GOOGL, AAPL; etc. 
        </p>

    </div>


    <div>
        &nbsp;Symbol:
        <asp:TextBox ID="TB_Symbol" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="BT_ADD" runat="server" Text="Hinzufügen" OnClick="BT_ADD_Click" />
        &nbsp;<asp:Button ID="BT_DeleteStock" runat="server" OnClick="BT_DeleteStock_Click" Text="Delete Stock" />
        &nbsp;
        <asp:Button ID="BT_DeleteStocks" runat="server" OnClick="BT_DeleteStocks_Click" Text="Clear All" />
    </div>
    <p>
        <asp:GridView ID="GV_Compare" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="CompareDB" Height="240px" Width="292px" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="symbols" HeaderText="symbols" SortExpression="symbols" />
                <asp:BoundField DataField="openstock" HeaderText="openstock" SortExpression="openstock" />
                <asp:BoundField DataField="High" HeaderText="High" SortExpression="High" />
                <asp:BoundField DataField="Low" HeaderText="Low" SortExpression="Low" />
                <asp:BoundField DataField="Volume" HeaderText="Volume" SortExpression="Volume" />
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
        <asp:SqlDataSource ID="CompareDB" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnectionDB %>" SelectCommand="SELECT [symbols], [openstock], [High], [Low], [Volume] FROM [Compare]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="CompareStock" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnection %>" SelectCommand="SELECT [symbols], [openstock], [High], [Low], [Volume] FROM [Compare]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Stock" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectStock %>" SelectCommand="SELECT [symbols], [openstock], [High], [Low], [Closestock], [Volume], [AdjustedClose] FROM [Compare]"></asp:SqlDataSource>
    </p>

</asp:Content>
