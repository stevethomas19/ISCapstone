var viz;

$(".dashboards.predict").ready(function() {
    console.log( "ready!" );
    var vizDiv = document.getElementById('predictViz');
    var vizURL = "https://public.tableau.com/views/UtahDonationsForecast/DonationsForecast?:embed=y&:display_count=yes"
    var options = {
      width: '1000px',
      height: '900px'
    };
    viz = new tableau.Viz(vizDiv, vizURL, options);
});

var tableau;
