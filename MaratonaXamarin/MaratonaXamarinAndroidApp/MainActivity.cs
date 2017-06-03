using Android.App;
using Android.Widget;
using Android.OS;
using MaratonaXamarin.Shared;
using System;
using System.Linq;

namespace MaratonaXamarinAndroidApp
{
    [Activity(Label = "MaratonaXamarinAndroidApp", MainLauncher = true, Icon = "@drawable/icon")]
    public class MainActivity : Activity
    {
        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView (Resource.Layout.Main);

            var button = this.FindViewById<Button>(Resource.Id.btnCarregar);
            var listview = this.FindViewById<ListView>(Resource.Id.lvwItens);

            button.Click += async (sender, e) =>
            {
                var api = new UserApi();
                var users = await api.ListAsync(new Developer
                {
                    Id = Guid.NewGuid().ToString(),
                    Name = "Rafael",
                    Email = "contato@rafaelestevao.com.br",
                    State = "SP",
                    City = "São Vicente"
                });

                listview.Adapter = new ArrayAdapter(this, 
                                    Android.Resource.Layout.SimpleListItemSingleChoice,
                                    users.OrderBy(o => o.Name).Select(x => $"{x.Id} {x.Name}").ToArray()

                    );
            };
        }

    }
}

