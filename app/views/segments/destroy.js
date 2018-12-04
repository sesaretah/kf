$("#settings-detail").replaceWith("<%= escape_javascript(render(:partial => 'segments/business_segment')) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
