// Generated by CoffeeScript 1.3.3
(function() {
  var StatusUpdates;

  StatusUpdates = (function() {

    function StatusUpdates(client) {
      this.client = client;
    }

    StatusUpdates.prototype.responseHandler = function(errMessage, callback) {
      if (errMessage == null) {
        errMessage = 'Error';
      }
      return function(err, statusCode, responseBody) {
        if (err) {
          return callback(err);
        }
        if (statusCode !== 200) {
          return callback(new Error(errMessage));
        } else {
          return callback(null, responseBody);
        }
      };
    };

    StatusUpdates.prototype.get = function(options, callback) {
      return this.client.get("/status_updates", options, this.responseHandler("Status update get error", callback));
    };

    StatusUpdates.prototype.post = function(options, callback) {
      if (this.client.token == null) {
        return callback(new Error('No token provided, method requires authentication'));
      }
      if ((options != null ? options.message : void 0) == null) {
        return callback(new Error('Message parameter not present'));
      }
      return this.client.post("/status_updates", options, this.responseHandler("Status update post error", callback));
    };

    StatusUpdates.prototype["delete"] = function(options, callback) {
      if (this.client.token == null) {
        return callback(new Error('No token provided, method requires authentication'));
      }
      if ((options != null ? options.id : void 0) == null) {
        return callback(new Error('id parameter not present'));
      }
      return this.client.del("/status_updates/" + options.id, options, this.responseHandler("Status update delete error", callback));
    };

    return StatusUpdates;

  })();

  module.exports = StatusUpdates;

}).call(this);
