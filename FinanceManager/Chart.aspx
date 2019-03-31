<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Chart.aspx.cs" Inherits="FinanceManager.test1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Graphenverlauf</h1>
    <div>
        <ul>
            <li>Symbol: Symbol der Aktie eingeben</li>
            <li>Beginn: DD-MM-YYY</li>
            <li>Ende: DD-MM-YYY</li>
        </ul>

    </div>


    <p>
        <span>Symbol :&nbsp;
        <asp:TextBox ID="TB_Symbol" runat="server" Width="180px"></asp:TextBox>
            &nbsp;</span>
        <span>Beginn:&nbsp;&nbsp;<asp:TextBox ID="TB_Begin" runat="server" Width="192px"></asp:TextBox>
            &nbsp; Ende:&nbsp;&nbsp;<asp:TextBox ID="TB_End" runat="server" Width="192px"></asp:TextBox>
            &nbsp; </span>
        <asp:Button ID="SearchButton" runat="server" Text="Suchen" OnClick="SearchButton_Click" />
        &nbsp;&nbsp;
        <asp:Button ID="BT_Table" runat="server" OnClick="BT_Table_Click" Text="Tabellenansicht" />
    &nbsp;
        <asp:Button ID="BT_verlauf" runat="server" Enabled="False" OnClick="BT_verlauf_Click" OnLoad="BT_verlauf_Load" Text="Verlauf" Visible="False" />
    </p>
    <div>
        <p style="margin-left: 30px">
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
            <asp:SqlDataSource ID="StockData" runat="server" ConnectionString="<%$ ConnectionStrings:StockConnection %>" SelectCommand="SELECT [openstock], [High], [Low], [Closestock], [Volume], [AdjustedClose], [DateTime], [symbols] FROM [stock]"></asp:SqlDataSource>
        </p>
    </div>
    <p>
        &nbsp;
    </p>
</asp:Content>
