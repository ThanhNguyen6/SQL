function booksinfo() {
    let p = fetch("https://fakerestapi.azurewebsites.net/api/v1/books").then(function (response) {
        return response.json()
    })

    p.then(function (data) {
        console.log(data);
        let tbody = document.querySelector('tbody');
        tbody.innerHTML = "";
        let length = data.length;
        for (let i = 0; i < length; i++) {
            let tr = "<tr> <td>" + data[i].id + "</td> <td> "
                + data[i].title + "</td> <td>"
                + data[i].description + "</td> <td>"
                + data[i].pageCount + "</td> <td>"
                + data[i].excerpt + "</td> <td>"
                + data[i].publishDate + "</td>  </tr > ";
            tbody.innerHTML += tr;
        }
    }).catch(function (e) {

    })
}