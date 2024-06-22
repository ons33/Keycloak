<#macro kw component="button" rest...>
  <${component}
    class="flex justify-center px-4 py-2 relative rounded-lg text-sm text-white w-full focus:outline-none focus:ring-2"
    style="width: 315px; height: 50px;background-color:#343a40;display:inline-block; font-weight:600 !important"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
