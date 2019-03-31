<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Aktienchecker.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="margin-left: 20px">AktienChecker</h1>
    <p>
        Dies ist ein Aktienchecker, der aktuelle Aktiendaten aufruft.
    </p>
    <p>
        Folgende möglichkeiten gibt es: Graphenverlauf mit Liste und Vergleich
    </p>
    <ul>
        <li>Graphenverlauf mit Liste: Es wird hier die Historische Daten einer Aktie(Symbol) aufgelistet.<ul>
            <li>Es gibt eine Historie, die nur für eingeloggte Personen verfügbar sind</li>
            </ul>
        </li>
        <li>Vergleich: Man kann mehrere Symbole vergleichen. Diese werden von aktueller Zeitpunkt aufgerufen.
        </li>
    </ul>
    <p>
        &nbsp;</p>
    <p>
        <asp:Image ID="Image1" runat="server" Height="258px" ImageUrl="~/Picture/HomepageMeme.jpg" Width="438px" />
    </p>
</asp:Content>
