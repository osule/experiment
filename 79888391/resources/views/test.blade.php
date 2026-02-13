<html>
<head>
    <title>Test page</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
</head>
<body>
<button id="test-btn">Test</button>
<div id="response"></div>
<script>
    document.getElementById('test-btn').addEventListener('click', () => {
        const formData = new FormData();
        formData.append('test_input', 'Hello from JS!');

        fetch('/test', {
            // headers: {
            //     'X-CSRF-TOKEN': '{{ csrf_token() }}'
            // },
            method: 'POST',
            body: formData
        })
        .then(async response => {
            const respJson = await response.json();
            document.getElementById('response').innerHTML = respJson.message;
        });
    });
</script>
</body>
</html>
