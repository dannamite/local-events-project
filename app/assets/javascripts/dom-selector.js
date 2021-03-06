function DomSelector() {

  return {
    element: function(element) {
      return document.querySelector(element);
    },

    all: function(elements) {
      var nodeList = document.querySelectorAll(elements);
      nodeList.forEach = function() {
        return Array.prototype.forEach.apply(this, arguments);
      };
      return nodeList;
    },

    child: function(child) {
      return {
        from: function(parentElement) {
          return parentElement.querySelector(child);
        }
      };
    },

    children: function(children) {
      return {
        from: function(parentElement) {
          var nodeList = parentElement.querySelectorAll(children);
          nodeList.forEach = function() {
            return Array.prototype.forEach.apply(this, arguments);
          }
          return nodeList;
        }
      };
    }
  };
}
