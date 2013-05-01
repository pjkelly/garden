var parseDate = function(timestamp) {
  if (timestamp) {
    var date = new Date(timestamp*1000);
    return (date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear();
  }
}

var extractDataFromRegularPost = function(post) {
  return { title : post['regular-title'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromLinkPost = function(post) {
  return { title : post['link-text'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromQuotePost = function(post) {
    return { title : post['quote-text'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromPhotoPost = function(post) {
    return { title : post['photo-caption'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromConversationPost = function(post) {
    return { title : post['conversation-title'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromVideoPost = function(post) {
  return { title : post['video-caption'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromAudioPost = function(post) {
  return { title : post['audio-caption'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var extractDataFromAnswerPost = function(post) {
  return { title : post['question'], url : post['url'], date : parseDate(post['unix-timestamp']) };
}

var parsePost = function(post) {
  switch(post.type) {
  case 'regular':
    return extractDataFromRegularPost(post);
    break;
  case 'link':
    return extractDataFromLinkPost(post);
    break;
  case 'quote':
    return extractDataFromQuotePost(post);
    break;
  case 'photo':
    return extractDataFromPhotoPost(post);
    break;
  case 'conversation':
    return extractDataFromConversationPost(post);
    break;
  case 'video':
    return extractDataFromVideoPost(post);
    break;
  case 'audio':
    return extractDataFromAudioPost(post);
    break;
  case 'answer':
    return extractDataFromAnswerPost(post);
    break;
  default:
    return { error : true }
  }
}