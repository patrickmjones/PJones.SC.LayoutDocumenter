<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="LayoutDocumenter.aspx.cs" Inherits="PJones.SC.LayoutDocumenter.sitecore_modules.shell.Custom.LayoutDocumenter.LayoutDocumenter" %>

<%@ Register TagPrefix="sc" Namespace="Sitecore.Web.UI.WebControls" Assembly="Sitecore.Kernel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PJones - Layout Documenter</title>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=5">
        <link href="/sitecore/shell/themes/standard/default/Default.css" rel="stylesheet">
        <script src="/sitecore/shell/controls/Gecko.js" type="text/javascript"></script>
        <script src="/sitecore/shell/controls/Sitecore.js" type="text/javascript"></script>
        <script src="/sitecore/shell/controls/lib/prototype/prototype.js" type="text/javascript"></script>
        <meta name="GENERATOR" content="Sitecore">
        <meta http-equiv="imagetoolbar" content="no">
        <meta http-equiv="imagetoolbar" content="false">
    </head>

    <style>
        html, body {
            background: #fff;
        }
        .layout-report {
            padding: 1em 3em;
        }
        .thumbnail-image {
            max-width: 250px;
            float: left;
        }

        .component-item:after {
            content: "";
            clear: both;
            display: block;
        }

        h2 {
            font-size: 1.6em;
        }

        h3 {
            margin: .2em 0 .3em;
            font-size: 1.4em;
        }

        td {
            font-size: 1.1em;
            vertical-align: top;
            padding: .5em;
            border-bottom: 1px solid #ccc;
        }

        .item-meta {
            margin: .2em 0;
        }
        
        .layout-documenter-header img {
            float: left;
            margin: 10px 10px 10px 20px;
        }
        .layout-documenter-header {
            overflow: hidden;
            color: #fff;
        }
        .layout-documenter-header h2 {
            margin-bottom: 0;
            color: #fff;
        }
        .layout-documenter-header p {
            margin: 0;
            color: #fff;
        }
        .layout-documenter-header p a {
            color: #BCFCBC;
        }
        footer {
            margin: 2em 3em 1em;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="UnauthorizedPanel" runat="server" Visible="false">
                <div class="layout-report">
                    <p>You are not authorized to use the Layout Documenter.</p>
                </div>
            </asp:Panel>

            <asp:Panel ID="LayoutDocumenterHeader" runat="server">
                <div class="scGreenGradient">
                    <div class="layout-documenter-header">
                        <img src="/~/icon/Applications/48x48/text_rich_colored.png" border="0" />
                        <h2 class="scLargeFont">Layout Documenter</h2>
                        <p>Provides documentation on current Placeholders, Renderings and Sublayouts in the system.</p>
                    </div>
                </div>


                <div class="layout-report">
                    <h2 id="placeholders">Placeholders</h2>
                    <table>
                        <asp:Repeater runat="server" ID="rptPlaceholders" ItemType="Sitecore.Data.Items.Item">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <sc:Image ID="Image1" Field="Icon" runat="server" Item="<%# Item %>" />
                                    </td>
                                    <td>
                                        <h3><%# Item.DisplayName %></h3>
                                        <p class="item-meta">
                                            <strong>Placeholder Key:</strong>
                                            <sc:Text ID="Text1" runat="server" Field="Placeholder Key" Item="<%# Item %>" />
                                        </p>
                                        <p class="item-meta">
                                            <strong>Allowed Controls:</strong>
                                            <asp:Literal runat="server" ID="litCompatibleRenderings" />
                                        </p>
                                        <div class="component-description">
                                            <sc:Text ID="Text2" Field="Description" runat="server" Item="<%# Item %>" />
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>                    

                    <h2 id="sublayouts">Sublayouts</h2>
                    <table>
                        <asp:Repeater runat="server" ID="rptSublayouts" ItemType="Sitecore.Data.Items.Item">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <img id="ThumbnailImage" runat="server" class="thumbnail-image" />
                                    </td>
                                    <td>
                                        <h3><%# Item.DisplayName %></h3>
                                        <p class="item-meta">
                                            <strong>Datasource Template:</strong>
                                            <asp:Literal runat="server" ID="litDatasourceTemplate" />
                                        </p>
                                        <p class="item-meta">
                                            <strong>Compatible Renderings:</strong>
                                            <asp:Literal runat="server" ID="litCompatibleRenderings" />
                                        </p>
                                        <div class="component-description">
                                            <sc:Text ID="Text3" Field="Description" runat="server" Item="<%# Item %>" />
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>

                </div>
            </asp:Panel>

            <footer>
                <p class="copyright">&copy; agencyQ 2014</p>
            </footer>
        </div>
    </form>
</body>
</html>
