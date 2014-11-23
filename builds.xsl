<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<!DOCTYPE html>
		<html>
			<head>
				<script src="chart.min.js"></script>
				<script type="text/javascript">

					//document.getElementById("canvasLoc").addEventListener("load", getGraphs,false);
						function main(){

						var values = [];
							<xsl:for-each select="builds/build">

								values.push({"coverage1": <xsl:value-of select="@coverage1"/>, "coverage2": <xsl:value-of select="@coverage2"/>});

							</xsl:for-each>
							//var canvas = '&lt;canvas id=&quot;myChart&quot; width=&quot;400&quot; height=&quot;400&quot;&gt;&lt;/canvas&gt;
							var str = "";
							for(var value in values){

								str+= "&lt;div style=&apos;position: absolute; border-left: 2px; border-top: 2px; border-bottom: 2px; border-style: solid; border-color: white; width:" + (values[value].coverage1*2) + "; background-color: green;left: 0px; height: 30; top:"+ ((value * 30)+2) + "; &apos;&gt;"+ values[value].coverage1 +"%&lt;/div&gt;";

								str+="&lt;div style=&apos;position: absolute; border-left: 0px; border-top: 2px; border-bottom: 2px; border-right: 2px; border-style: solid; border-color: white; width:"+ ((100-values[value].coverage1)*2) + "; background-color: red; height: 30px; left: " + (values[value].coverage1*2) + "; top:"+ ((value * 30)+2) + ";&apos;&gt;&lt;/div&gt;";
							}
							document.getElementById("main").innerHTML = str;

							//getGraphs();
						}

						function getgraphs(){

							var values = [];
							var ctx = [];
							var charts = [];
							<xsl:for-each select="builds/build">

								values.push({"name":&quot;<xsl:value-of select="@name"/>&quot;,  "coverage1": <xsl:value-of select="@coverage1"/>, "coverage2": <xsl:value-of select="@coverage2"/>});

								

							</xsl:for-each>

							var str="";
							for(var value in values){

							//alert(value)
								//str="&lt;canvas id=&apos;" + values[value].name +"&apos; style=&apos;position:absolute; width: 100px; height: 100px; left 50px; top: "+ (value*120) +"px; border:1px solid #000000;&apos;&gt;&lt;/canvas&gt;"
								//document.getElementById("canvasLoc").innerHTML+=str;

								ctx.push(document.getElementById("canvas"+value).getContext("2d"));							

								var data = [
								    {
								        value: values[value].coverage1,
								        color:"green",
								        highlight: "#5AD3D1",
								        label: "Covered"
								    },
								    {
								        value: (100-values[value].coverage1),
								        color: "red",
								        highlight: "#FF5A5E",
								        label: "Not Covered"
								    },
								]

								var options = {
									animationEasing: "none",
									animation: false
								}

								charts.push(new Chart(ctx[value]).Doughnut(data,options));
								//alert(document.getElementById("canvasLoc").innerHTML)
							}


						}
						

					
				</script>
			</head>
			<body onload="getgraphs()">
				<div id="main" ></div><p/>
				<div  id="canvasLoc" >
					<canvas id="canvas0" style="width: 100px; height: 80px; position:absolute; left: 20px; top: 20px;"></canvas>
					<canvas id="canvas1" style="width: 100px; height: 80px; position:absolute; left: 20px; top: 130px;"></canvas>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>