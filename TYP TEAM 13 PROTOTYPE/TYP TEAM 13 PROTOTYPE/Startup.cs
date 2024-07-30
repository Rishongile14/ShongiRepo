using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TYP_TEAM_13_PROTOTYPE
{
	public class Startup
	{
		public void Configuration(IAppBuilder app)
		{
			// Configure the application here
			app.UseWelcomePage(); // Just an example middleware
		}
	}
}