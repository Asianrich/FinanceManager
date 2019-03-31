<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="FinanceManager.LoginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h1>Einloggen</h1>
    <div>
        Login<br />
        <asp:TextBox ID="TB_LogUser" runat="server" OnTextChanged="TB_LogUser_TextChanged"></asp:TextBox>
        <br />
        <br />
        Passwort<br />
        <asp:TextBox ID="TB_LogPw" runat="server"></asp:TextBox>
    </div>
    <div>

        <br />
        <asp:Button ID="BT_Log" runat="server" OnClick="BT_Log_Click" Text="Einloggen" />
        <br />

    </div>
    <h2>Registrieren</h2>
    <div>


    &nbsp;Login<br />
        <asp:TextBox ID="TB_RegUser" runat="server"></asp:TextBox>
        <br />
        <br />
        Passwort<br />
        <asp:TextBox ID="TB_RegPw" runat="server"></asp:TextBox>
        <br />
        <br />
        Passwort erneut eingeben<br />
        <asp:TextBox ID="TB_RegConf" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="BT_registry" runat="server" OnClick="BT_registry_Click" Text="Registrieren" />


    </div>


</asp:Content>
