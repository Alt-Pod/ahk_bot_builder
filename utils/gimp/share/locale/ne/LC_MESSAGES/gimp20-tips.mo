��             +         �  9   �  �     �   �  X   �  �     �   �  �  �  �   c  N   	  �   c	  �   <
  �   �
    �  �   �  �   [  �   �    �  �   �  /  �    �  �   �  �   X  �   �  �   t  �   5  �      j   �  �   �  �   �  |   b  �   �  �  �  x   }  �  �     �  �   �  o  �     1"  �  O$  �  (  7  �)  �  +  �  -  �  �.  �  �0  W  �3  c  �5  �  B7  �  �8  �  �;  A  p=  �  �@  �  �C     ^E  5  _G  �  �H    >J  X  ZL  �   �M  �  �N  }  zQ  l  �R  �  eT               
                                                                                                   	                              <big>Welcome to the GNU Image Manipulation Program!</big> <tt>Ctrl</tt>-click with the Bucket Fill tool to have it use the background color instead of the foreground color. Similarly, <tt>Ctrl</tt>-clicking with the eyedropper tool sets the background color instead of the foreground color. <tt>Ctrl</tt>-clicking on the layer mask's preview in the Layers dialog toggles the effect of the layer mask. <tt>Alt</tt>-clicking on the layer mask's preview in the Layers dialog toggles viewing the mask directly. <tt>Ctrl</tt>-drag with the Rotate tool will constrain the rotation to 15 degree angles. <tt>Shift</tt>-click on the eye icon in the Layers dialog to hide all layers but that one. <tt>Shift</tt>-click again to show all layers. A floating selection must be anchored to a new layer or to the last active layer before doing other operations on the image. Click on the &quot;New Layer&quot; or the &quot;Anchor Layer&quot; button in the Layers dialog, or use the menus to do the same. After you enabled &quot;Dynamic Keyboard Shortcuts&quot; in the Preferences dialog, you can reassign shortcut keys. Do so by bringing up the menu, selecting a menu item, and pressing the desired key combination. If &quot;Save Keyboard Shortcuts&quot; is enabled, the key bindings are saved when you exit GIMP. You should probably disable &quot;Dynamic Keyboard Shortcuts&quot; afterwards, to prevent accidentally assigning/reassigning shortcuts. Click and drag on a ruler to place a guide on an image. All dragged selections will snap to the guides. You can remove guides by dragging them off the image with the Move tool. GIMP allows you to undo most changes to the image, so feel free to experiment. GIMP supports gzip compression on the fly. Just add <tt>.gz</tt> (or <tt>.bz2</tt>, if you have bzip2 installed) to the filename and your image will be saved compressed. Of course loading compressed images works too. GIMP uses layers to let you organize your image. Think of them as a stack of slides or filters, such that looking through them you see a composite of their contents. If a layer's name in the Layers dialog is displayed in <b>bold</b>, this layer doesn't have an alpha-channel. You can add an alpha-channel using Layer→Transparency→Add Alpha Channel. If some of your scanned photos do not look colorful enough, you can easily improve their tonal range with the &quot;Auto&quot; button in the Levels tool (Colors→Levels). If there are any color casts, you can correct them with the Curves tool (Colors→Curves). If you stroke a path (Edit→Stroke Path), the paint tools can be used with their current settings. You can use the Paintbrush in gradient mode or even the Eraser or the Smudge tool. If your screen is too cluttered, you can press <tt>Tab</tt> in an image window to toggle the visibility of the toolbox and other dialogs. Most plug-ins work on the current layer of the current image. In some cases, you will have to merge all layers (Image→Flatten Image) if you want the plug-in to work on the whole image. Not all effects can be applied to all kinds of images. This is indicated by a grayed-out menu-entry. You may need to change the image mode to RGB (Image→Mode→RGB), add an alpha-channel (Layer→Transparency→Add Alpha Channel) or flatten it (Image→Flatten Image). Pressing and holding the <tt>Shift</tt> key before making a selection allows you to add to the current selection instead of replacing it. Using <tt>Ctrl</tt> before making a selection subtracts from the current one. To create a circle-shaped selection, hold <tt>Shift</tt> while doing an ellipse select. To place a circle precisely, drag horizontal and vertical guides tangent to the circle you want to select, place your cursor at the intersection of the guides, and the resulting selection will just touch the guides. When you save an image to work on it again later, try using XCF, GIMP's native file format (use the file extension <tt>.xcf</tt>). This preserves the layers and every aspect of your work-in-progress. Once a project is completed, you can save it as JPEG, PNG, GIF, ... You can adjust or move a selection by using <tt>Alt</tt>-drag. If this makes the window move, your window manager uses the <tt>Alt</tt> key already. You can create and edit complex selections using the Path tool. The Paths dialog allows you to work on multiple paths and to convert them to selections. You can drag a layer from the Layers dialog and drop it onto the toolbox. This will create a new image containing only that layer. You can drag and drop many things in GIMP. For example, dragging a color from the toolbox or from a color palette and dropping it into an image will fill the current selection with that color. You can draw simple squares or circles using Edit→Stroke Selection. It strokes the edge of your current selection. More complex shapes can be drawn using the Path tool or with Filters→Render→Gfig. You can get context-sensitive help for most of GIMP's features by pressing the F1 key at any time. This also works inside the menus. You can perform many layer operations by right-clicking on the text label of a layer in the Layers dialog. You can save a selection to a channel (Select→Save to Channel) and then modify this channel with any paint tools. Using the buttons in the Channels dialog, you can toggle the visibility of this new channel or convert it to a selection. You can use <tt>Ctrl</tt>-<tt>Tab</tt> to cycle through all layers in an image (if your window manager doesn't trap those keys...). You can use the middle mouse button to pan around the image (or optionally hold <tt>Spacebar</tt> while you move the mouse). You can use the paint tools to change the selection. Click on the &quot;Quick Mask&quot; button at the bottom left of an image window. Change your selection by painting in the image and click on the button again to convert it back to a normal selection. Project-Id-Version: gimp-tips.HEAD.ne
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2007-06-07 03:44+0100
PO-Revision-Date: 2007-07-27 16:25+0545
Last-Translator: Shyam Krishna Bal <shyamkrishna_bal@yahoo.com>
Language-Team: Nepali <info@mpp.org.np>
Language: ne
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
Plural-Forms: nplurals=2;plural=(n!=1)
 <big>जीएनयु छवि परिचालन कार्यक्रममा स्वागत छ !</big> <tt>Ctrl</tt>-अग्रभूमि रङको सट्टा पृष्ठभूमि रङ प्रयोग गर्न बकेट भर्ने उपकरणसँग क्लिक गर्नुहोस् । त्यस्तै प्रकारले, <tt>Ctrl</tt>-आइड्रपर उपकरणसँग क्लिक गर्नाले अग्रभूमि रङको सट्टा पृष्ठभूमि रङ सेट गर्दछ । <tt>Ctrl</tt>-तहहरूको संवादमा तह मास्कको पूर्वावलोकनमा क्लिक गर्नाले तह मास्कको प्रभाव टगल गर्दछ । <tt>Alt</tt>-तहहरूको संवादमा तह मास्कको पूर्वावलोकनमा क्लिक गर्नाले प्रत्यक्ष रूपमा मास्क हेर्न टगल गर्दछ । <tt>Ctrl</tt>- घुमाउने उपकरण द्वारा तान्दा परिक्रमणलाई १५ डिग्री कोणमा निर्धारण गर्दछ। सबै तहहरू तर त्यो एउटालाई लुकाउन तह संवादमा आँखा प्रतिमा छविमा <tt>Shift</tt>-क्लिक गर्नुहोस्। सबै तहहरू देखाउनका लागि <tt>Shift</tt>-फेरी क्लिक गर्नुहोस्। छविमा अन्य सञ्चालन गर्नु पहिले अन्तिम सक्रिय तहमा वा एउटा नयाँ तहमा उत्प्लावन चयन एङ्कर हुनुपर्दछ। तह संवादमा &quot; नयाँ तह &quot; वा &quot; आड तह &quot; बटनमा क्लिक गर्नुहोस्, वा उस्तै गर्नका लागि मेनु प्रयोग गर्नुहोस्। यदि तपाईँले प्राथमिकता संवादमा, &quot; गतिशिल कुञ्जीपाटी सर्टकटहरू &quot; सक्रिय गरिसक्नु भए पछि, तपाईँले सर्टकट कुञ्जीहरू पुन: मानाङ्कन गर्न सक्नुहुन्छ। यसलाई मेनु वस्तु छानेर र चाहिएको कुञ्जी संयोजन दवाएर मेनुलाई माथी ल्याएर त्यस्तो गर्नुहोस्। यदि &quot; कुञ्जीपाटि सर्टकट &quot; सङ्ग्रह गर्नुहोस्, सक्रिय छ भने, कुञ्जी संयोजनहरू तपाईँले गिम्प बन्द गर्नु भएपछि बचत हुन्छ। मार्गदर्शकलाई छविमा राख्न रुलरलाई क्लिक गरी तान्निहोस्। सबै तानिएका चयन मार्गदर्शकमा सटाइनेछ। तपाईँले मार्गदर्शकलाई सार्ने उपकरण छविबाट बाहिर तानेर हटाउन सक्नुहुन्छ। गिम्पले छविको धेरै परिवर्तनहरूलाई पूर्वावस्थामा फर्काउन अनुमति दिन्छ, त्यसैले प्रयोग गर्न खुल्ला महशुस गर्नुहोस्। गिम्पले फ्लाइमा gzip सङ्कुचन समर्थन गर्दछ। <tt>.gz</tt> (वा <tt>.bz2</tt> मात्र थप्नुहोस्, यदि तपाईँसँग bzip2 स्थापित छ भने) फाइलमा र तपाईँको छवि सङ्कुचित बचत हुँनेछ। अवश्य पनि लोडिङ सङ्कचित छविहरूले पनि काम गर्दछ। गिम्पले तपाईँलाई आफ्नो छवि व्यवस्थित गर्न तह प्रयोग गर्दछ। यसलाई स्लाईडहरू वा चयनको थाक भनेर सम्झनुहोस्, जस्तै यसमा हेर्दा तपाईँले त्यसको सामग्रीहरूको मिश्रित देख्न सक्नुहुन्छ। यदि तह संवादमा एउटा तहको नाम <b>बाक्लो</b>मा प्रर्दशित भएमा, त्यो तहसँग अल्फा-च्यानल छैन। तपाईँले तह-&gt;पारदर्शीता-&gt;अल्फा च्यानल थप्नुहोस् प्रयोग गरेर अल्फा च्यानल थप गर्न सक्नुहुन्छ। यदि तपाईँको केही स्क्यान गरिएको फोटोहरू राम्रो रङिन देखिएन भने, तपाईँले तह उपकरणहरू (तह-&gt; रङहरू-&gt; तहरू) &quot; मा स्वत &quot; बटनसँगै तिनिहरूको टोनल दायरा सजिलै परिमार्जन गर्न सक्नुहुन्छ। यदि कुनै रङको झुकाव भए, तपाईँले बक्र उपकरण (तह-&gt;रङहरू-&gt;बक्रहरू) ले सच्याउन सक्नुहुन्छ। यदि तपाईँले मार्ग (सम्पादन-&gt;स्ट्रोक बाटो) स्ट्रोक गर्नुभयो भने रङ लगाउने उपकरणहरू चालु सेटिङसँगै प्रयोग गर्न सकिन्छ। तपाईँले पेन्ट ब्रसलाई ग्रेडिएन्ट मोड वा साथै मेट्ने वस्तु वा अस्पष्ट पार्ने उपकरण प्रयोग गर्न सक्नुहुन्छ। यदि तपाईँको स्क्रिन एकदम गडबड छ भने तपाईँले उपकरण बाकस र अरू संवादलाई लुकाउन वा देखाउन छवि सञ्झ्यालमा धेरै पटक <tt>Tab</tt> थिच्न सक्नुहुन्छ। धेरै जसो प्लगइनहरूले चालु छविको चालु तहमा काम गर्दछ। केही केसहरूमा, यदि तपाईँ पूरै छविमा प्लगइनले काम गराउन चाहनुहुन्छ भने तपाईँले सबै तहहरू (Image→Flatten Image) गाभ्नु पर्नेछ। सबै प्रभावहरू सबै प्रकारको छविमा लागू गर्न सकिँदैन । यो ग्रेयड-आउट मेनु प्रविष्टिद्वारा इंकित गरिएको हुन्छ । तपाईँले आरजीबी (Image→Mode→RGB) मा छवि मोड परिवर्तन गर्न आवश्यक छ, एउटा अल्फा च्यानल (Layer→Transparency→Add Alpha Channel) थप्नुहोस् वा यसलाई (Image→Flatten Image) समतल पार्नुहोस् । चयन गर्नुभन्दा पहिले <tt>Shift</tt> कुञ्जीलाई थिच्दा वा होल्ड गर्दा त्यसले तपाईँलाई बदल्नुको सट्टा हालको चयन थप्न अनुमति दिन्छ। चयन गर्नुभन्दा पहिले <tt>Ctrl</tt> प्रयोग गर्दा हालको एउटाबाट घटाउदछ। गोलो साइज चयन सिर्जना गर्न, दीर्घवृत्त चयन गरिरहेको बेलामा <tt>Shift</tt> होल्ड गर्नुहोस्। गोलाकार उचित तरिकाले राख्न, तपाईँले चयन गर्न चहानुभएको गोलाकारमा तेर्सो र ठाडो मार्गदर्शक ट्यान्जेन्ट तान्नुहोस्, तपाईँको कर्सरलाई मार्गदर्शकहरूको प्रतिच्छेदनमा राख्नुहोस्, र परिणाम चयनले मार्गदर्शकहरूलाई मात्र स्पर्श गर्दछ। जब तपाईँले छविमा फेरि पछि काम गर्न बचत गर्नुहुन्छ, GIMP को नजिकको फाइल ढाँचा (फाइल विस्तार <tt>.xcf</tt> प्रयोग गर्नुहोस्) XCF प्रयोग गर्ने प्रयास गर्नुहोस्। यसले तहहरू र तपाईँको कामको प्रगतिको हरेक भावको सुरक्षा गर्दछ। एकपटक परियोजना पूरा भएपछि, तपाईँले JPEG, PNG, GIF, ... को रूपमा त्यसलाई बचत गर्न सक्नुहुन्छ। तपाईँले <tt>Alt</tt>-तान्ने प्रयोग गरेर चयन समायोजन गर्न वा सार्न सक्नुहुन्छ। यदि यसले सञ्झ्याल सर्यो भने, तपाईँको सञ्झ्याल प्रबन्धकले <tt>Alt</tt> कुञ्जी पहिले नै प्रयोग गर्दछ।  तपाईँले बाटो उपकरण प्रयोग गरेर कठिन चयन सिर्जना र सम्पादन गर्न सक्नुहुन्छ। बाटो संवादले तपाईँलाई अनेकौ बाटोहरूमा काम गर्न अनुमति दिन्छ र साथै तिनिहरूलाई चयनमा परिवर्तन गर्न पनि अनुमति दिन्छ। तपाईँले तह संवादबाट तह तानेर त्यसलाई उपकरण बाकसमा छोड्न सक्नुहुन्छ। यसले त्यो तह समावेश गरी नयाँ छवि सिर्जना गर्दछ। तपाईँले गिम्पमा धेरै वस्तुहरू तान्न र छोड्न सक्नुहुन्छ। उदाहरणका लागि, उपकरण बाकस वा रङदानीबाट रङ तानेर छविमा छाड्नाले हालको छवि भर्दछ वा त्यो रङसँगै छानिन्छ। तपाईँ सम्पादन ->स्ट्रोक चयन प्रयोग गरेर साधारण वर्ग वा वृत्त कोर्न सक्नुहुन्छ । यसले तपाईँको हालको चयनको किनारा स्ट्रोक गर्दछ । मार्ग उपकरण वा फिल्टर→रेन्डर→Gfig प्रयोग गरेर अति कठिन आकारहरू कोर्न सकिन्छ । तपाईँले कुनै पनि समयमा F1 थिचेर गिम्पको विशेषताहरूको सामाग्री सम्वेदनशील मद्दत पाउन सक्नुहुन्छ। यसले मेनुको भित्र पनि काम गर्दछ। तपाईँले तह संवादमा तहको पाठ तहमा दायाँ-क्लिकद्वारा धेरै तह परिचालन सम्पादन गर्न सक्नुहुन्छ। तपाईँले माध्यम (माध्यममा चयन ->बचत गर्नुहोस्) मा चयन बचत गर्न सक्नुहुन्छ र त्यसपछि यो माध्यमलाई कुनै रङ लगाउने उपकरणले परिमार्जन गर्नुहोस्। माध्यम संवादहरूमा बटन प्रयोग गरेमा, तपाईँले यस नयाँ माध्यमको दृश्यात्मकता टगल गर्न सक्नुहुन्छ वा चयनमा परिवर्तन गर्न सक्नुहुन्छ। (यदि तपाईँको सञ्झ्याल प्रबन्धकले सो कुञ्जीहरू ट्रयाप गर्दैन भने) तपाईँले कुनै छविमा सबे तहहरू मार्फत घुमाउन <tt>Ctrl</tt>-<tt>Tab</tt> प्रयोग गर्न सक्नुहुन्छ । तपाईँ छवि वरिपरि प्यान गर्न बीचको माउस बटन प्रयोग गर्न सक्नुहुन्छ (वा वैकल्पिक रूपमा तपाईँले मास सार्दा <tt>स्पेसबार</tt> समात्न सक्नुहुन्छ) । तपाईँले चयन परिवर्तन गर्न रङ लगाउने उपकरण प्रयोग गर्न सकिन्छ। &quot;शिघ्र मास्क&quot; बटन छवि सञ्झ्यालको तल बायाँपट्टि क्लिक गर्नुहोस्। छविमा रङ लगाएर तपाईँको चयन परिवर्तन गर्नुहोस् र फेरी त्यसलाई उल्टाएर साधारण चयनमा ल्याउन बटनमा क्लिक गर्नुहोस्। 