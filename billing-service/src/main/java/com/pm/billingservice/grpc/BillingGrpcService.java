package com.pm.billingservice.grpc;

import billing.BillingResponse;
import billing.BillingServiceGrpc.BillingServiceImplBase;
import io.grpc.stub.StreamObserver;
import net.devh.boot.grpc.server.service.GrpcService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@GrpcService
public class BillingGrpcService extends BillingServiceImplBase {
    private static final Logger log = LoggerFactory.getLogger(BillingGrpcService.class);

    @Override
    public void createBillingAccount(billing.BillingRequest billingRequest, StreamObserver<billing.BillingResponse> responseStreamObserver) {
        log.info("Create billing account request received for user: {}", billingRequest.toString());
        BillingResponse response = BillingResponse.newBuilder()
                .setBillingAccountId("123")
                .setStatus("ACTIVE")
                .build();

        responseStreamObserver.onNext(response);
        responseStreamObserver.onCompleted();
    }
}
