<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Chart.aspx.cs" Inherits="FinanceManager.test1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Graphenverlauf</h1>

    <p>
        <span>Symbol :&nbsp;
        <asp:TextBox ID="TB_Symbol" runat="server" Width="180px"></asp:TextBox>
            &nbsp;</span>
        <span>Beginn:&nbsp;&nbsp;<asp:TextBox ID="TB_Begin" runat="server" Width="192px"></asp:TextBox>
            &nbsp; Ende:&nbsp;&nbsp;<asp:TextBox ID="TB_End" runat="server" Width="192px"></asp:TextBox>
            &nbsp; </span>
        <asp:Button ID="SearchButton" runat="server" Text="Suchen" OnClick="SearchButton_Click" />
    </p>
    <div>
        <p style="margin-left:30px">
            <asp:Label ID="LB_Symbol" runat="server" Text="Symbol"></asp:Label>
        </p>
    </div>

    <div style="margin: 0px 0px 0px 30px;">
        <p>

            <asp:Chart ID="StockChart" runat="server" Height="628px" Width="1326px" DataSourceID="StockData">
                <Series>
                    <asp:Series ChartArea="OpenStock" ChartType="Line" Name="OpenStock" XValueMember="DateTime" YValueMembers="openstock" IsXValueIndexed="True">
                    </asp:Series>
                    <asp:Series ChartArea="High" ChartType="Line" Name="High" XValueType="DateTime" XValueMember="DateTime" IsXValueIndexed="true" YValueMembers="High">
                    </asp:Series>
                    <asp:Series ChartArea="Low" ChartType="Line" Name="Low" XValueType="DateTime" XValueMember="DateTime" IsXValueIndexed="True" YValueMembers="Low">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="OpenStock">
                    </asp:ChartArea>
                    <asp:ChartArea Name="High">
                    </asp:ChartArea>
                    <asp:ChartArea Name="Low">
                    </asp:ChartArea>
                </ChartAreas>
                <Titles>
                    <asp:Title Name="OpenStock" DockedToChartArea="OpenStock" Text="OpenStock">
                    </asp:Title>
                    <asp:Title DockedToChartArea="High" Name="High" Text="High">
                    </asp:Title>
                    <asp:Title DockedToChartArea="Low" Name="Low" Text="Low">
                    </asp:Title>
                </Titles>
            </asp:Chart>
            <asp:SqlDataSource ID="StockData" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnection %>" SelectCommand="SELECT [symbols], [openstock], [High], [Low], [Closestock], [Volume], [AdjustedClose], [DateTime] FROM [stock]"></asp:SqlDataSource>
        </p>
    </div>
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="StockData" ForeColor="#333333" GridLines="None">
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
    </div>
    <p>
        &nbsp;
    </p>
</asp:Content>
