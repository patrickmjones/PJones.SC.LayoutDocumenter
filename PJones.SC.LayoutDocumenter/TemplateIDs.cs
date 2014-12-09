using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Sitecore.Data;

namespace PJones.SC.LayoutDocumenter
{
	public static class TemplateIDs
	{
		public static ID Placeholder;

		static TemplateIDs()
		{
			TemplateIDs.Placeholder = new ID("{5C547D4E-7111-4995-95B0-6B561751BF2E}");
		}
	}
}