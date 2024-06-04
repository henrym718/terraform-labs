exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify('¡Hola Mundo!'),
    };
    return response;
};

//aws s3 cp <FILE_NAME.EXT> s3://<BUCKET_NAME>/ --profile <PROFILE_NAME>