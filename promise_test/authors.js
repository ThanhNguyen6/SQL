function authorsinfo() {
    let p = fetch("https://fakerestapi.azurewebsites.net/api/v1/Authors").then(function (response) {
        return response.json()
    })

    p.then(function (data) {
        console.log(data);
        let tbody = document.querySelector('tbody');
        tbody.innerHTML = "";
        let length = data.length;
        for (let i = 0; i < length; i++) {
            let tr = "<tr> <td>" + data[i].id + "</td> <td>" + data[i].idBook + "</td> <td>" + data[i].firstName + "</td> <td>" + data[i].lastName + "</td>  </tr>";
            tbody.innerHTML += tr;
        }
    }).catch(function (e) {

    })
}