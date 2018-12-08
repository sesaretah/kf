$("#settings-detail").replaceWith("<%= escape_javascript(render(:partial => 'faqs/business_faqs')) %>");
new Noty({
    type: 'error',
    theme    : 'relax',
    timeout: 2000,
    layout: 'bottomLeft',
    text: '<%=t :destroyed_successfully%>'
}).show();
