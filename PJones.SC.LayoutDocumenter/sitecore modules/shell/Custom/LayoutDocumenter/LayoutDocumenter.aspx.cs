using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Sitecore.Data;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;

namespace PJones.SC.LayoutDocumenter.sitecore_modules.shell.Custom.LayoutDocumenter
{
	public partial class LayoutDocumenter : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Sitecore.Security.Accounts.User u = Sitecore.Context.User;
			if (u.IsAdministrator || u.IsInRole("Sitecore Client Authoring"))
			{
				Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
				Item LayoutRoot = master.GetItem(Sitecore.ItemIDs.LayoutRoot);
				Sitecore.Data.ID SublayoutID = Sitecore.TemplateIDs.Sublayout;

				rptSublayouts.DataSource = LayoutRoot.Axes.GetDescendants().Where(d => d.TemplateID == SublayoutID).OrderBy(o => o.DisplayName);
				rptSublayouts.ItemDataBound += rptSublayouts_ItemDataBound;
				rptSublayouts.DataBind();

				Sitecore.Data.ID PlaceholderID = TemplateIDs.Placeholder;
				rptPlaceholders.DataSource = LayoutRoot.Axes.GetDescendants().Where(d => d.TemplateID == PlaceholderID).OrderBy(o => o.DisplayName);
				rptPlaceholders.ItemDataBound += rptPlaceholders_ItemDataBound;
				rptPlaceholders.DataBind();
			}
			else
			{
				UnauthorizedPanel.Visible = true;
				LayoutDocumenterHeader.Visible = false;
			}
		}

		void rptPlaceholders_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{			
			Item slItem = (Item)e.Item.DataItem;
			if (slItem != null)
			{

				var allowedControlsField = (MultilistField)slItem.Fields["Allowed Controls"];
				if (allowedControlsField != null && allowedControlsField.Count > 0)
				{
					((Literal)e.Item.FindControl("litCompatibleRenderings")).Text = String.Join(", ", allowedControlsField.GetItems().Select(s => s.DisplayName));
				}
				else
				{
					((Literal)e.Item.FindControl("litCompatibleRenderings")).Text = "Unspecified";
				}
			
			}
		}

		void rptSublayouts_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			Item slItem = (Item)e.Item.DataItem;
			if (slItem != null)
			{
				var tField = (ThumbnailField)slItem.Fields[Sitecore.FieldIDs.Thumbnail];
				if(!String.IsNullOrEmpty(tField.Value)) {
					string url = Sitecore.Resources.Media.MediaManager.GetMediaUrl(tField.MediaItem);
					var ThumbnailImage = (HtmlImage)e.Item.FindControl("ThumbnailImage");
					ThumbnailImage.Src = url+"?mw=200&mh=200";
				}
				
				var datasourceTemplateReferenceField = (ReferenceField)slItem.Fields["Datasource Template"];
				if (datasourceTemplateReferenceField != null && datasourceTemplateReferenceField.TargetItem != null)
				{
					((Literal)e.Item.FindControl("litDatasourceTemplate")).Text = datasourceTemplateReferenceField.TargetItem.DisplayName;
				}
				else
				{
					((Literal)e.Item.FindControl("litDatasourceTemplate")).Text = "Unspecified";
				}
				
				var compatibleRenderingsField = (MultilistField)slItem.Fields["Compatible Renderings"];
				if (compatibleRenderingsField != null && compatibleRenderingsField.Count > 0)
				{
					((Literal)e.Item.FindControl("litCompatibleRenderings")).Text = String.Join(", ", compatibleRenderingsField.GetItems().Select(s => s.DisplayName));
				}
				else
				{
					((Literal)e.Item.FindControl("litCompatibleRenderings")).Text = "Unspecified";
				}
			}
		}
	}
}