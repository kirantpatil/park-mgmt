$(function() {

   /* 
    var object = document.getElementById("svg1");
    object.onload=function() {
      var svgdoc;
      try {
        svgdoc = object.contentDocument;
        alert("Green :: SVG in object supported hurray!!!");
      } catch(e) {
         try {
           svgdoc = object.getSVGDocument();
        alert("Red :: SVG in object supported hurray!!!");
         } catch (e) {
      alert("SVG in object not supported in your environment");
      }
    }

     if (!svgdoc) return;

     var rect = svgdoc.getElementById("slot10254");
     rect.style.setProperty("fill", "green");
     alert(rect.style.getPropertyValue("fill"));
  }
*/ 
  
         
    var source = new EventSource('/user_stream');

    source.addEventListener('results', function(e){
      console.log('Received a message:', e.data);
      if ( $.parseJSON(e.data).lstatus ) {
      var b = $.parseJSON(e.data).lstatus;
      var zcu = $.parseJSON(e.data).zcid;
      var floor = $.parseJSON(e.data).fname;
      var building = $.parseJSON(e.data).bname;
	//alert($('park\\:b').attr('value'));
	//alert($('park\\:f').attr('value'));
	//alert($('park\\:ccu').attr('value'));
	//alert($('park\\:zcu1').attr('value'));
	//alert($('park\\:zcu2').attr('value'));
      svg_change(b,zcu,floor,building);
      } else {
      var vacant  = $.parseJSON(e.data).vacant;
      var occupied = $.parseJSON(e.data).occupied;
      var total   = $.parseJSON(e.data).total;
                $('#vacant').text(vacant);
                $('#filled').text(occupied);
                $('#total').text(total);
      }
    });
       

	function svg_change(b,zcu,fl,bu) {
          var object = document.getElementById(bu+fl);
          var svgdoc;
            svgdoc = object.contentDocument;

               var a = b.split("");
	       var rect, color;
	       var i = 0, j = i+1;
               var len = b.length;
	       //alert (a);
               for (; i < len; i++, j++) {
                 rect = svgdoc.getElementById("slot" + j + zcu);
                 //alert(rect.style.getPropertyValue("fill"));
                //color = rect.css('fill'); 
		//alert (a[i]);
                //console.log('color:', color);  // logicto
	        //	alert(rect.fill);        // to implement
		//if (color == "blue") {         // reserved //verify what is the best soln..
                //  alert ("Slot is reserved");
		//} else 
                if (a[i] == 1){ 
                  rect.style.setProperty("fill", "red");
		} else if(a[i] == 0)  {
                  rect.style.setProperty("fill", "green");
		}
               }
         }


    source.addEventListener('finished', function(e){
      console.log('Close:', e.data);
      source.close();
    });


          $('#btnTest').click(function(e)
           {
           });    
   });
