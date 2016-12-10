var viz;

$(".dashboards.tableau").ready(function() {
    console.log( "ready!" );
    var vizDiv = document.getElementById('myViz');
    var vizURL = "https://public.tableau.com/views/IS415CapstoneFinal/UtahPoliticalContributionsfrom2000to2016?:embed=y&:display_count=yes"
    var options = {
      width: '1000px',
      height: '900px'
    };
    viz = new tableau.Viz(vizDiv, vizURL, options);
});

var tableau;
