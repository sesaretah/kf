$("#settings-detail").replaceWith("<%= escape_javascript(render(:partial => 'segments/business_segment')) %>");
new Noty({
    type: 'success',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :changed_successfully%>'
}).show();
