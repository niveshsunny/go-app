FROM golang:1.22.5 as build
WORKDIR /app
#copy dependencies file to workdir
COPY go.mod . 
# download dependencies 
RUN go mod download
COPY . .
# build the image 
RUN go build -o main .


FROM gcr.io/distroless/base
COPY --from=build /app/main .
COPY --from=build /app/static /static
EXPOSE 8080
CMD [ "./main" ]