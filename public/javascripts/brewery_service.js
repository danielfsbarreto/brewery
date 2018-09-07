class BrewerySevice {
  static retrieveBeerContainers() {
    $.ajax({url: "/truck.json",
      success: function(result) {
        $(".alert-danger").css("visibility", "hidden");
        result.containers.forEach(function(container) {
          var container_id = container.kind.replace(" ", "-")
          var container_card = $(
            `
              <div class="col-sm-6" id="${container_id}">
                <div class="card" style="margin: 5px 0">
                  <div class="card-body">
                    <h5 class="card-title">${container.kind}</h5>
                    <p class="card-text">Current temperature = <strong>${container.current_temp}°C</strong></p>
                    <div class="alert alert-warning" role="alert">
                      <span>
                        <strong>WARNING:</strong> This container must be between
                        <strong>${container.min_temp}°C</strong> and <strong>${container.max_temp}°C</strong>.
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            `
          );
          if (container.ideal) {
            container_card.find(".alert").css("visibility", "hidden");
          }
          var element = $("#beer-containers").find(`#${container_id}`);
          if (element.length != 0) {
            element.replaceWith(container_card);
          } else {
            $("#beer-containers").append(container_card);
          }
        });
      },
      error: function() {
        $("#beer-containers").empty();
        $(".alert-danger").html(
          $(`<span><strong>ERROR:</strong> Could not fetch information from the server.</span>`)
        ).css("visibility", "visible");
      }
    });
  }
}
