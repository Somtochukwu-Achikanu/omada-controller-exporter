FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o omada-controller-exporter .

# Create the final image
FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/omada-controller-exporter .

# Ensure the binary is executable
RUN chmod +x /root/omada-controller-exporter

EXPOSE 6779
CMD ["/root/omada-controller-exporter"]
