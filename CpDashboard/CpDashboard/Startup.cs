using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CpDashboard.Startup))]
namespace CpDashboard
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
