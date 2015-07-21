$(function() {

   /* 
     if (!svgdoc) return;

     var rect = svgdoc.getElementById("slot10254");
     rect.style.setProperty("fill", "green");
     alert(rect.style.getPropertyValue("fill"));
  }
*/ 
  
         
    var source = new EventSource('/park_stream');

    source.addEventListener('results', function(e){
      console.log('Received a message:', e.data);
      if ( $.parseJSON(e.data).lstatus ) {
      var b = $.parseJSON(e.data).lstatus;
      var zcu = $.parseJSON(e.data).zcid;
      var floor = $.parseJSON(e.data).fname;
      var building = $.parseJSON(e.data).bname;
      svg_change(b,zcu,floor,building);

      } else if ($.parseJSON(e.data).total){
      var vacant  = $.parseJSON(e.data).vacant;
      var occupied = $.parseJSON(e.data).occupied;
      var total   = $.parseJSON(e.data).total;
      var floor = $.parseJSON(e.data).fid;
      var building = $.parseJSON(e.data).bid;
                $('#vacant'+floor+building).text(vacant);
                $('#filled'+floor+building).text(occupied);
                $('#total'+floor+building).text(total);
      } else if ($.parseJSON(e.data).total_b){
      var vacant  = $.parseJSON(e.data).vacant_b;
      var occupied = $.parseJSON(e.data).occupied_b;
      var total   = $.parseJSON(e.data).total_b;
      var building = $.parseJSON(e.data).bid;
                $('#vacant'+building).text(vacant);
                $('#filled'+building).text(occupied);
                $('#total'+building).text(total);
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
