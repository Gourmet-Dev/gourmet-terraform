# AWS Region 설정
variable "gourmet_region" {
    default = "ap-northeast-2"
}

# AWS 클러스터 이름
variable "gourmet_id" {
    default = "gourmet"
    type = string
}