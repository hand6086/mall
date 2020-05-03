package com.hand.core.basic.config.redis;

/*@Configuration  
@EnableRedisHttpSession(maxInactiveIntervalInSeconds= 7200)  */
public class RedisSessionConfig {
	
	/*@Bean 
	@Order(1)
	public HttpSessionStrategy httpSessionStrategy() {  
	    return new CookieHttpSessionStrategy();  
	}
	
	@Bean
	@Order(0)
	public FieldRetrievingFactoryBean redisRetrievingFactoryBean() {
		FieldRetrievingFactoryBean fieldRetrievingFactoryBean = new FieldRetrievingFactoryBean();
		fieldRetrievingFactoryBean
				.setStaticField("org.springframework.session.data.redis.config.ConfigureRedisAction.NO_OP");
		return fieldRetrievingFactoryBean;
	}
*/
}
