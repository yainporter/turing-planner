import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  const loadSlides = function(presentationId) {
    gapi.client.slides.presentations.get({
        presentationId: presentationId
    }).then(function(response) {
        var slides = response.result.slides;
        slides.forEach(function(slide, index) {
            console.log("Slide #" + (index + 1) + " ID: " + slide.objectId);
            // Fetch thumbnail or other slide details here
        });
    }, function(response) {
        console.log("Failed to get presentation: " + response.result.error.message);
    });
  }
}
