<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->

<cfparam name="attributes.keywords" default="">
<cfparam name="attributes.isNew" default="1">
<cfset counter=0 />
<cfoutput>
<div id="contentSearch">
<h3>#application.rbFactory.getKeyValue(session.rb,'collections.contentsearch')#</h3>
	<input id="parentSearch" name="parentSearch" value="#HTMLEditFormat(attributes.keywords)#" type="text" class="text" maxlength="50"/><input type="button" class="submit" onclick="loadSiteFilters('#attributes.siteid#',document.getElementById('parentSearch').value,0);" value="#application.rbFactory.getKeyValue(session.rb,'collections.search')#" />
	</div>
</cfoutput>
<cfif not attributes.isNew>
<cfset request.rsList=application.contentManager.getPrivateSearch(attributes.siteid,attributes.keywords)/>
 <table class="mura-table-grid stripe">
    <tr> 
      <th class="varWidth"><cfoutput>#application.rbFactory.getKeyValue(session.rb,'collections.selectnewsection')#</cfoutput></th>
	  <th class="administration">&nbsp;</th>
    </tr><cfif request.rslist.recordcount>
     <cfoutput query="request.rslist" startrow="1" maxrows="100">	
		<cfset crumbdata=application.contentManager.getCrumbList(request.rslist.contentid, attributes.siteid)/>
        <cfif structKeyExists(crumbdata[1],"parentArray") and not listFind(arraytolist(crumbdata[1].parentArray),attributes.contentid) and request.rslist.type neq 'File' and request.rslist.type neq 'Link'>
		<cfset counter=counter+1/>
		<tr <cfif not(counter mod 2)>class="alt"</cfif>>
		
          <td class="varWidth">#application.contentRenderer.dspZoomNoLinks(crumbdata,request.rslist.fileExt)#</td>
		<td class="administration"><ul class="one"><li class="add"><a title="#application.rbFactory.getKeyValue(session.rb,'collections.add')#" href="javascript:;" onClick="addContentFilter('#request.rslist.contentid#','#JSStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.type.#request.rslist.type#'))#','#JSStringFormat(request.rslist.menuTitle)#'); return false;">&nbsp;</a></li></ul>
		  </td>
		</tr>
	 	</cfif>
       </cfoutput>
	 	<cfelse>
		<tr class="alt"><cfoutput>  
		  <td class="noResults" colspan="2"><cfoutput>#application.rbFactory.getKeyValue(session.rb,'collections.nosearchresults')#</cfoutput></td>
		</tr></cfoutput>
		</cfif>
  </table>
</td></tr></table>
</cfif>